#!/usr/bin/env python3
"""
migrate_to_timeline.py

將 dialogtest 各場景從 N.mcfunction 逐步分派架構
遷移至新的多軌時間軸系統（僅搬移 text 軌，動畫/移動軸留待手動補充）

執行方式：
    python migrate_to_timeline.py
    python migrate_to_timeline.py --dry-run   # 預覽，不寫入檔案
"""

import re
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8")

BASE = Path(__file__).parent / "data/dialogtest/functions"
SKIP = {"fire/fire1"}  # 已手動遷移，跳過

DRY_RUN = "--dry-run" in sys.argv

# 舊系統的 run.* 設定行（遷移時移除）
OLD_RUN_PATTERNS = [
    r"data modify storage dialogtest:story run\.playing\b",
    r"data modify storage dialogtest:story run\.cd\b",
    r"data modify storage dialogtest:story run\.chapter\b",
    r"data modify storage dialogtest:story run\.paragraph\b",
    r"data modify storage dialogtest:story run\.dialog\b",
]


def find_scenes() -> dict:
    """找出所有含有編號步驟檔案的場景目錄。"""
    scenes = {}
    for start_file in sorted(BASE.rglob("start.mcfunction")):
        scene_dir = start_file.parent
        rel = scene_dir.relative_to(BASE).as_posix()
        if rel in SKIP:
            continue
        numbered = sorted(
            [f for f in scene_dir.iterdir() if re.fullmatch(r"\d+\.mcfunction", f.name)],
            key=lambda f: int(f.stem),
        )
        if numbered:
            scenes[rel] = {"dir": scene_dir, "steps": numbered, "start": start_file}
    return scenes


def parse_step(path: Path) -> dict:
    """從一個步驟檔案中提取：translate key、cd、是否帶玩家名。"""
    text = path.read_text(encoding="utf-8")

    key_m = re.search(r'"translate"\s*:\s*"([^"]+)"', text)
    cd_m  = re.search(r"run\.cd set value (\d+)", text)

    return {
        "key": key_m.group(1) if key_m else None,
        "cd":  int(cd_m.group(1)) if cd_m else 40,
        "type": "text_player" if "tag=PlayerName" in text else "text",
    }


def build_text_track(steps: list) -> tuple[str, int]:
    """
    組出 text 軌的 NBT list 字串，以及最後一句結束後的 t 值（供 ctrl 軌使用）。
    """
    events = []
    t = 0
    for step in steps:
        if step["key"]:
            events.append(f'{{t:{t},type:"{step["type"]}",key:"{step["key"]}"}}'  )
        t += step["cd"]
    return ",".join(events), t


def strip_old_run_lines(content: str) -> str:
    """移除舊系統的 run.chapter / run.paragraph 等設定行。"""
    kept = []
    for line in content.splitlines():
        stripped = line.strip()
        if any(re.match(p, stripped) for p in OLD_RUN_PATTERNS):
            continue
        kept.append(line)
    # 移除尾端空行
    while kept and not kept[-1].strip():
        kept.pop()
    return "\n".join(kept)


def generate_start(scene_rel: str, old_start: str, text_events: str, t_cleanup: int) -> str:
    """組出新的 start.mcfunction 內容。"""
    scene_id = scene_rel.replace("/", "_")
    setup = strip_old_run_lines(old_start)

    return f"""{setup}

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{text_events}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{{t:{t_cleanup},type:"fn",fn:"dialogtest:operations/timeline/end"}}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "{scene_id}"
data modify storage dialogtest:story run.scene_tick set value 0
"""


def ensure_end_fn():
    """確保通用的 operations/timeline/end.mcfunction 存在。"""
    path = BASE / "operations/timeline/end.mcfunction"
    if not path.exists():
        content = (
            "# 通用場景結束（停止時間軸）\n"
            "data modify storage dialogtest:story run.playing set value 0b\n"
            "data remove storage dialogtest:story run.mode\n"
        )
        if not DRY_RUN:
            path.write_text(content, encoding="utf-8")
        print(f"  [create] operations/timeline/end.mcfunction")


def migrate_scene(rel: str, info: dict):
    print(f"\n{'[DRY] ' if DRY_RUN else ''}── {rel} ({len(info['steps'])} steps) ──")

    steps = [parse_step(f) for f in info["steps"]]
    text_events, t_cleanup = build_text_track(steps)

    old_start = info["start"].read_text(encoding="utf-8")
    new_start = generate_start(rel, old_start, text_events, t_cleanup)

    if DRY_RUN:
        print(f"  [preview] start.mcfunction (text軌: {len(steps)} 項, cleanup t={t_cleanup})")
        print(f"    text track: {text_events[:120]}{'...' if len(text_events) > 120 else ''}")
    else:
        info["start"].write_text(new_start, encoding="utf-8")
        print(f"  [updated] start.mcfunction")

        for f in info["steps"]:
            f.unlink()
            print(f"  [deleted] {f.name}")


def main():
    scenes = find_scenes()
    if not scenes:
        print("找不到需要遷移的場景。")
        return

    print(f"找到 {len(scenes)} 個場景待遷移：{', '.join(scenes)}\n")

    ensure_end_fn()

    for rel, info in scenes.items():
        migrate_scene(rel, info)

    print(f"\n{'[DRY RUN 完成，未寫入任何檔案]' if DRY_RUN else '✓ 遷移完成！'}")
    print("提醒：動畫軸（run.union）、移動軸（run.villager）請手動補充。")


if __name__ == "__main__":
    main()
