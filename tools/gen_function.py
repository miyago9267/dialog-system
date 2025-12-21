"""將文字劇本自動轉換成一連串 mcfunction 的小工具。

使用範例：

	python gene.py --source data/static/ghost_town \
			   --output data/dialogtest/functions/ghost_town

程式會掃描 ``--source`` 資料夾的所有 ``.txt`` 檔，並在 ``--output`` 中
建立同名的資料夾（去除副檔名）。每個資料夾都會包含一個
``start.mcfunction``，以及依文字行數產生的編號檔案。每個編號檔會輸出
``tellraw``，引用 ``{namespace}.{chapter}.{paragraph}.lineX`` 這類翻譯鍵，
並依照既有規則更新 ``dialogtest:story`` 的 storage，以便串起整段對話。
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path


START_TEMPLATE = """data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.cd set value {start_cd}
data modify storage dialogtest:story run.chapter set value {chapter}
data modify storage dialogtest:story run.paragraph set value {paragraph}
data modify storage dialogtest:story run.dialog set value 0
"""


def make_step(
	namespace: str,
	chapter: str,
	paragraph: str,
	index: int,
	total: int,
	cooldown: int,
	is_player_line: bool,
) -> str:
	key = f"{namespace}.{chapter}.{paragraph}.line{index + 1}"
	payload = {"translate": key}
	if is_player_line:
		payload["with"] = [{"selector": "@p","color": "aqua"}]
	lines = [f"tellraw @a {json.dumps(payload, ensure_ascii=False)}", ""]
	if index == total - 1:
		lines.extend(
			[
				"data modify storage dialogtest:story run.playing set value 0b",
				f"data modify storage dialogtest:story run.cd set value {cooldown}",
				"data modify storage dialogtest:story run.dialog set value 0",
			]
		)
	else:
		lines.extend(
			[
				f"data modify storage dialogtest:story run.cd set value {cooldown}",
				f"data modify storage dialogtest:story run.dialog set value {index + 1}",
			]
		)
	return "\n".join(lines) + "\n"


def iter_text_files(source_dir: Path):
	for path in sorted(source_dir.iterdir()):
		if path.is_file() and path.suffix.lower() == ".txt":
			yield path


def extract_speaker(raw_line: str) -> str | None:
	stripped = raw_line.strip().lstrip("\ufeff")
	if not stripped:
		return None
	for sep in (":", "："):
		if sep in stripped:
			speaker = stripped.split(sep, 1)[0].strip().strip('\"')
			return speaker or None
	return None


def read_lines(path: Path, keep_empty: bool) -> tuple[list[str], list[bool]]:
	raw_lines = path.read_text(encoding="utf-8").splitlines()
	lines: list[str] = []
	player_flags: list[bool] = []
	for line in raw_lines:
		if not line.strip() and not keep_empty:
			continue
		lines.append(line)
		player_flags.append(extract_speaker(line) == "主角")
	return lines, player_flags


def main():
	parser = argparse.ArgumentParser(description=__doc__)
	parser.add_argument("--source", required=True, help="包含 .txt 劇本的來源資料夾")
	parser.add_argument("--output", required=True, help="輸出 mcfunction 的資料夾")
	parser.add_argument("--chapter", help="寫入 storage run.chapter 的值，預設為輸出資料夾名稱")
	parser.add_argument("--namespace", default="story", help="tellraw 使用的翻譯命名空間 (預設: story)")
	parser.add_argument("--cooldown", type=int, default=40, help="每句對話之間的冷卻時間")
	parser.add_argument("--start-cd", type=int, default=1, help="start.mcfunction 中的初始冷卻時間")
	parser.add_argument("--keep-empty", action="store_true", help="保留空白行並視為對話內容")
	args = parser.parse_args()

	source_dir = Path(args.source).resolve()
	output_dir = Path(args.output).resolve()

	if not source_dir.is_dir():
		raise SystemExit(f"Source directory not found: {source_dir}")

	output_dir.mkdir(parents=True, exist_ok=True)

	chapter = args.chapter or output_dir.name

	for txt_file in iter_text_files(source_dir):
		paragraph = txt_file.stem
		lines, player_flags = read_lines(txt_file, keep_empty=args.keep_empty)
		if not lines:
			print(f"[WARN] Skip {txt_file.name}: no dialog lines detected")
			continue

		paragraph_dir = output_dir / paragraph
		paragraph_dir.mkdir(parents=True, exist_ok=True)

		start_path = paragraph_dir / "start.mcfunction"
		start_path.write_text(
			START_TEMPLATE.format(start_cd=args.start_cd, chapter=chapter, paragraph=paragraph),
			encoding="utf-8",
		)

		for index, _ in enumerate(lines):
			step_path = paragraph_dir / f"{index}.mcfunction"
			step_content = make_step(
				args.namespace,
				chapter,
				paragraph,
				index,
				len(lines),
				args.cooldown,
				player_flags[index],
			)
			step_path.write_text(step_content, encoding="utf-8")

		print(f"Generated {paragraph} ({len(lines)} dialog steps)")


if __name__ == "__main__":
	main()