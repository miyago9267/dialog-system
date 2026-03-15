"""
批次套用轉場效果到所有時間軸場景
- 所有軌道 t 值 +25（開場黑幕延遲）
- 移除 start.mcfunction 中的手動 blindness/darkness effect
- ctrl 軌的 cleanup fn 前插入 fade_to_black（結尾轉場）

用法：
  python apply_transition.py          # dry run（預覽變更）
  python apply_transition.py --apply  # 實際套用
"""

import re
import sys
import os
from pathlib import Path

OFFSET = 25
FADE_TO_BLACK_FN = "dialogtest:operations/transition/fade_to_black"
FADE_GAP = 20  # fade_to_black 在 cleanup 前幾 tick

FUNCTIONS_ROOT = Path(__file__).parent / "dialogtest" / "data" / "dialogtest" / "functions"

dry_run = "--apply" not in sys.argv


def find_timeline_starts():
    """找出所有使用時間軸的 start.mcfunction"""
    results = []
    for path in FUNCTIONS_ROOT.rglob("start.mcfunction"):
        content = path.read_text(encoding="utf-8")
        if 'run.mode set value "timeline"' in content or "run.text set value" in content:
            results.append(path)
    return sorted(results)


def shift_track_times(line, offset):
    """將 run.XXX set value [...] 中的所有 t:N 值 +offset"""
    # 匹配 data modify storage dialogtest:story run.XXX set value [...]
    if "run." not in line or "set value [" not in line:
        return line, False

    def replace_t(m):
        old_val = int(m.group(1))
        new_val = old_val + offset
        return f"t:{new_val}"

    new_line = re.sub(r"t:(\d+)", replace_t, line)
    changed = new_line != line
    return new_line, changed


def insert_fade_to_black(line):
    """在 ctrl 軌的最後一個 fn 事件前插入 fade_to_black"""
    if "run.ctrl set value" not in line:
        return line, False

    # 已經有 fade_to_black 的跳過
    if FADE_TO_BLACK_FN in line:
        return line, False

    # 找出 ctrl 軌中所有事件，取最後一個的 t 值
    events = re.findall(r'\{[^}]+\}', line)
    if not events:
        return line, False

    # 找最後一個事件的 t 值（通常是 cleanup）
    last_event = events[-1]
    t_match = re.search(r't:(\d+)', last_event)
    if not t_match:
        return line, False

    cleanup_t = int(t_match.group(1))
    fade_t = cleanup_t - FADE_GAP

    fade_event = f'{{t:{fade_t},type:"fn",fn:"{FADE_TO_BLACK_FN}"}}'

    # 在最後一個事件前插入
    last_idx = line.rfind(last_event)
    new_line = line[:last_idx] + fade_event + "," + line[last_idx:]
    return new_line, True


def remove_blindness_darkness(lines):
    """移除手動的 blindness/darkness effect（開場黑幕改由 tick 共通處理）"""
    new_lines = []
    removed = []
    skip_next_blank = False

    for i, line in enumerate(lines):
        stripped = line.strip()
        # 移除 blindness/darkness effect 行
        if re.match(r"effect give @a (blindness|darkness)", stripped):
            removed.append(stripped)
            skip_next_blank = True
            continue
        # 移除相關的註解行
        if stripped.startswith("#") and any(kw in stripped for kw in ["黑幕", "blindness", "darkness", "fade"]):
            removed.append(stripped)
            skip_next_blank = True
            continue
        # 跳過移除後產生的連續空行
        if skip_next_blank and stripped == "":
            skip_next_blank = False
            continue
        skip_next_blank = False
        new_lines.append(line)

    return new_lines, removed


def process_file(path):
    """處理單一 start.mcfunction"""
    content = path.read_text(encoding="utf-8")
    lines = content.splitlines(keepends=True)
    changes = []

    # 1. 移除手動 blindness/darkness
    lines, removed = remove_blindness_darkness(lines)
    if removed:
        changes.append(f"  移除效果: {', '.join(removed)}")

    # 2. 軌道時間偏移 + ctrl 軌插入 fade_to_black
    new_lines = []
    for line in lines:
        # 先偏移時間
        new_line, shifted = shift_track_times(line, OFFSET)
        if shifted:
            changes.append(f"  時間偏移 +{OFFSET}: {line.strip()[:60]}...")

        # 再檢查 ctrl 軌是否需要插入 fade_to_black
        new_line, inserted = insert_fade_to_black(new_line)
        if inserted:
            changes.append(f"  插入 fade_to_black")

        new_lines.append(new_line)

    if not changes:
        return None

    new_content = "".join(new_lines)

    if not dry_run:
        path.write_text(new_content, encoding="utf-8")

    return changes


def main():
    mode = "DRY RUN" if dry_run else "APPLYING"
    print(f"=== 轉場效果批次套用 ({mode}) ===\n")

    starts = find_timeline_starts()
    print(f"找到 {len(starts)} 個時間軸場景\n")

    # 排除 fire1（已手動處理）
    fire1_path = FUNCTIONS_ROOT / "fire" / "fire1" / "start.mcfunction"

    modified = 0
    skipped = 0

    for path in starts:
        if path == fire1_path:
            print(f"[跳過] {path.relative_to(FUNCTIONS_ROOT)} (已手動處理)")
            skipped += 1
            continue

        changes = process_file(path)
        if changes:
            rel = path.relative_to(FUNCTIONS_ROOT)
            print(f"[{'變更' if not dry_run else '預覽'}] {rel}")
            for c in changes:
                print(c)
            modified += 1
        else:
            skipped += 1

    print(f"\n=== 結果: {modified} 個檔案{'已修改' if not dry_run else '將修改'}, {skipped} 個跳過 ===")
    if dry_run:
        print("加 --apply 參數實際套用變更")


if __name__ == "__main__":
    import io
    sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
    main()
