"""
批次套用觀察者模式到所有時間軸場景
- start.mcfunction: slowness+jump_boost → gamemode spectator + scene_camera marker
- cleanup.mcfunction: effect clear → gamemode adventure + kill marker

用法：
  python apply_spectator.py          # dry run
  python apply_spectator.py --apply  # 實際套用
"""

import re
import sys
import io
from pathlib import Path

FUNCTIONS_ROOT = Path(__file__).parent / "dialogtest" / "data" / "dialogtest" / "functions"
dry_run = "--apply" not in sys.argv


def find_timeline_starts():
    results = []
    for path in FUNCTIONS_ROOT.rglob("start.mcfunction"):
        content = path.read_text(encoding="utf-8")
        if 'run.mode set value "timeline"' in content or "run.text set value" in content:
            results.append(path)
    return sorted(results)


def process_start(path):
    content = path.read_text(encoding="utf-8")
    lines = content.splitlines(keepends=True)
    changes = []

    # 跳過已處理的（已有 gamemode spectator）
    if "gamemode spectator" in content:
        return None

    # 跳過沒有 slowness 的（不需要改）
    if "effect give @a slowness" not in content:
        return None

    new_lines = []
    skip_next_blank = False
    tp_line_found = False

    for i, line in enumerate(lines):
        stripped = line.strip()

        # 替換 slowness → gamemode spectator
        if stripped == "effect give @a slowness 999999 255 true":
            # 保留註解行（如果上一行是註解）
            new_lines.append("gamemode spectator @a\n")
            changes.append("slowness → gamemode spectator")
            skip_next_blank = True
            continue

        # 移除 jump_boost
        if stripped == "effect give @a jump_boost 999999 128 true":
            changes.append("移除 jump_boost")
            skip_next_blank = True
            continue

        # 移除相關註解
        if stripped.startswith("#") and any(kw in stripped for kw in ["鎖定玩家", "lock player"]):
            new_lines.append("# 切換觀察者模式（鎖位置由 timeline/tick 每 tick tp 處理）\n")
            changes.append("更新註解")
            continue

        if skip_next_blank and stripped == "":
            skip_next_blank = False
            continue
        skip_next_blank = False

        # 在 tp @a 前插入 scene_camera marker
        tp_match = re.match(r"tp @a (-?\d+\.?\d*) (-?\d+\.?\d*) (-?\d+\.?\d*) facing (-?\d+\.?\d*) (-?\d+\.?\d*) (-?\d+\.?\d*)", stripped)
        if tp_match and not tp_line_found:
            x, y, z = tp_match.group(1), tp_match.group(2), tp_match.group(3)
            fx, fy, fz = tp_match.group(4), tp_match.group(5), tp_match.group(6)
            new_lines.append(f'summon marker {x} {y} {z} {{Tags:["scene_camera"]}}\n')
            new_lines.append(f'execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing {fx} {fy} {fz}\n')
            new_lines.append(line)
            changes.append(f"插入 scene_camera marker at {x} {y} {z}")
            tp_line_found = True
            continue

        new_lines.append(line)

    if not changes:
        return None

    new_content = "".join(new_lines)
    if not dry_run:
        path.write_text(new_content, encoding="utf-8")

    return changes


def process_cleanup(path):
    content = path.read_text(encoding="utf-8")
    changes = []

    # 跳過已處理的
    if "gamemode adventure" in content:
        return None

    if "effect clear @a slowness" not in content:
        return None

    # 替換 effect clear slowness → gamemode adventure
    new_content = content.replace(
        "effect clear @a slowness",
        "gamemode adventure @a\nkill @e[tag=scene_camera]"
    )
    changes.append("slowness clear → gamemode adventure + kill camera")

    # 移除 effect clear jump_boost
    new_content = re.sub(r"\n?effect clear @a jump_boost\n?", "\n", new_content)
    changes.append("移除 jump_boost clear")

    if not dry_run:
        path.write_text(new_content, encoding="utf-8")

    return changes


def main():
    mode = "DRY RUN" if dry_run else "APPLYING"
    print(f"=== 觀察者模式批次套用 ({mode}) ===\n")

    starts = find_timeline_starts()
    print(f"找到 {len(starts)} 個時間軸場景\n")

    fire1_start = FUNCTIONS_ROOT / "fire" / "fire1" / "start.mcfunction"

    start_modified = 0
    cleanup_modified = 0

    for path in starts:
        if path == fire1_start:
            print(f"[跳過] {path.relative_to(FUNCTIONS_ROOT)} (已手動處理)")
            continue

        rel = path.relative_to(FUNCTIONS_ROOT)
        changes = process_start(path)
        if changes:
            print(f"[start] {rel}")
            for c in changes:
                print(f"  {c}")
            start_modified += 1

        # 找對應的 cleanup
        cleanup_path = path.parent / "cleanup.mcfunction"
        if cleanup_path.exists():
            changes = process_cleanup(cleanup_path)
            if changes:
                cleanup_rel = cleanup_path.relative_to(FUNCTIONS_ROOT)
                print(f"[cleanup] {cleanup_rel}")
                for c in changes:
                    print(f"  {c}")
                cleanup_modified += 1

    print(f"\n=== 結果: {start_modified} start + {cleanup_modified} cleanup {'已修改' if not dry_run else '將修改'} ===")
    if dry_run:
        print("加 --apply 參數實際套用")


if __name__ == "__main__":
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
    main()
