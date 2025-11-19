from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

COLOR_MAP = {
    "米迦爾": "§7【米迦爾】§r:",
    "尤尼恩": "§2【尤尼恩】§r:",
    "主角": "§b【%s】§r:",
    "約古": "§7【約古】§r:",
    "??": "§7【???】§r:",
    "????": "§7【???】§r:",
    "?????": "§7【???】§r:",
    "賽勒尼亞": "§4【賽勒尼亞】§r:",
    "自律水晶防禦裝置": "§8【自律水晶防禦裝置】§r:",
    "菲恩特": "§3【菲恩特】§r:",
    "奈迪拉提雅": "§d【奈迪拉提雅】§r:",
    "史利亞卡": "§4【史利亞卡】§r:",
    "女性的聲音": "§d【女性的聲音】§r:",
    "年幼的男孩": "§e【年幼的男孩】§r:",
    "人類": "§7【人類】§r:",
    "堯稚克": "§4【堯稚克】§r:",
    "眾人": "§7【眾人】§r:",
    "荒蛛群": "§7【荒蛛群】§r:",
    "法羅涅拉": "§3【法羅涅拉】§r:",
    "阿多賽忒喀": "§c【阿多賽忒喀】§r:",
    "阿多賽忒克": "§c【阿多賽忒克】§r:",
    "「奧婕提亞」": "§5【「奧婕提亞」】§r:",
    "特提卡": "§7【特提卡】§r:",
    "阿帝嘉": "§7【阿帝嘉】§r:",
    "阿帝嘉小聲說道": "§7【阿帝嘉】§r:",
}

DEFAULT_OUTPUT = Path(__file__).with_name("output.txt")


def convert_line(raw: str) -> str | None:
    raw = raw.strip()
    if not raw:
        return None
    if raw.startswith("(") or raw.startswith("（") or raw.startswith("-"):
        return raw
    speaker, sep, content = raw.partition(":")
    if not sep:
        return raw
    prefix = COLOR_MAP.get(speaker.strip(), f"§7【{speaker.strip()}】§r:")
    return f"{prefix}{content.strip()}"


def iter_text_files(source_dir: Path):
    for path in sorted(source_dir.iterdir()):
        if path.is_file() and path.suffix.lower() == ".txt":
            yield path


def parse_dialog_file(path: Path, keep_empty: bool) -> list[str]:
    converted: list[str] = []
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        text = convert_line(raw_line)
        if text is None:
            if keep_empty and not raw_line.strip():
                converted.append("")
            continue
        converted.append(text)
    return converted


def serialize_entries(namespace: str, chapter: str, paragraph: str, lines: list[str]) -> list[str]:
    serialized = []
    for idx, text in enumerate(lines, start=1):
        key = f"{namespace}.{chapter}.{paragraph}.line{idx}"
        serialized.append(f'  "{key}": {json.dumps(text, ensure_ascii=False)},')
    return serialized


def write_entries(entries: list[str], output_path: Path, append: bool) -> None:
    if not entries:
        print("[INFO] No entries generated.", file=sys.stderr)
        return
    output_path.parent.mkdir(parents=True, exist_ok=True)
    content = "\n".join(entries).rstrip() + "\n"
    if append and output_path.exists() and output_path.stat().st_size > 0:
        content = "\n" + content
    mode = "a" if append else "w"
    with output_path.open(mode, encoding="utf-8") as fh:
        fh.write(content)
    print(f"[OK] Wrote entries to {output_path}")


def main():
    parser = argparse.ArgumentParser(description="依據文字劇本生成翻譯鍵內容，輸出到 new_entries.txt。")
    parser.add_argument("--source", required=True, help="包含 .txt 劇本的來源資料夾 (如 data/static/wild_valley)")
    parser.add_argument("--chapter", help="覆寫翻譯鍵中的章節名稱，預設為來源資料夾名稱")
    parser.add_argument("--namespace", default="story", help="翻譯鍵命名空間 (預設: story)")
    parser.add_argument(
        "--output",
        default=str(DEFAULT_OUTPUT),
        help=f"輸出 new_entries 的檔案路徑 (預設: {DEFAULT_OUTPUT})",
    )
    parser.add_argument("--append", action="store_true", help="附加結果到輸出檔案尾端，而非覆寫")
    parser.add_argument("--keep-empty", action="store_true", help="保留空白行，並轉為空字串翻譯")
    args = parser.parse_args()

    source_dir = Path(args.source).resolve()
    if not source_dir.is_dir():
        raise SystemExit(f"Source directory not found: {source_dir}")

    chapter = args.chapter or source_dir.name
    all_entries: list[str] = []

    for txt_file in iter_text_files(source_dir):
        paragraph = txt_file.stem
        lines = parse_dialog_file(txt_file, keep_empty=args.keep_empty)
        if not lines:
            print(f"[WARN] Skip {txt_file.name}: no dialog lines detected", file=sys.stderr)
            continue
        all_entries.extend(serialize_entries(args.namespace, chapter, paragraph, lines))
        all_entries.append("")

    write_entries(all_entries, Path(args.output).resolve(), append=args.append)


if __name__ == "__main__":
    main()
