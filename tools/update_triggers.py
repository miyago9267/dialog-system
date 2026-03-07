#!/usr/bin/env python3
"""
觸發點座標映射工具

集中管理所有場景觸發點的座標。修改下方 TRIGGER_COORDS 字典後執行此腳本，
即可自動更新對應 trigger.mcfunction 中的 `positioned X Y Z` 座標。

用法：
    python tools/update_triggers.py            # 預覽變更（不寫入）
    python tools/update_triggers.py --apply    # 套用變更
"""

import re
import sys
from pathlib import Path

# ============================================================================
# 座標映射表
# 格式：  "chapter/scene": (X, Y, Z)
# 設為 None 表示座標尚未確認（不更新）
# ============================================================================

TRIGGER_COORDS = {
    # ── fire ──
    "fire/fire1":   (-2031, 14, 1760),
    "fire/fire2":   (-2399, 18, 1727),
    # fire3: trigger 變數觸發，無座標

    # ── water ──
    "water/water1": (-1749, 12, 1492),
    "water/water2": (-1749, 12, 1556),
    "water/water3": (-1749, 12, 1570),
    # water4: trigger 變數觸發，無座標

    # ── grass ──
    "grass/grass1": (-1413, 6, 1870),
    "grass/grass2": None,               # TODO: 座標待確認
    "grass/grass3": (-916, 6, 1916),
    # grass4: trigger 變數觸發，無座標

    # ── light ──
    "light/light1": None,               # TODO: 座標待確認（光源迷樓地下入口）
    "light/light2": None,               # TODO: 座標待確認（光源試煉場）
    "light/light3": None,               # TODO: 座標待確認（盡頭戰場）
    # light4: trigger 變數觸發，無座標
}

# ============================================================================
# 以下為工具邏輯，通常不需修改
# ============================================================================

# 專案根目錄（相對於此腳本位置）
SCRIPT_DIR = Path(__file__).resolve().parent
PROJECT_ROOT = SCRIPT_DIR.parent
FUNCTIONS_DIR = PROJECT_ROOT / "data" / "dialogtest" / "functions"

# 比對 trigger.mcfunction 中 `positioned X Y Z` 的正則
POSITIONED_RE = re.compile(
    r"(positioned\s+)"         # 前綴
    r"(-?\d+\s+-?\d+\s+-?\d+)" # 座標（三個整數）
    r"(\s+if\s+entity)"        # 後綴
)


def find_trigger_line(trigger_file: Path, scene_name: str):
    """在 trigger.mcfunction 中找到對應場景的座標觸發行"""
    # 從 "chapter/scene" 取得 scene 名稱（如 "fire1"）
    scene = scene_name.split("/")[1]
    lines = trigger_file.read_text(encoding="utf-8").splitlines(keepends=True)

    for i, line in enumerate(lines):
        # 找包含 positioned 且包含該場景 start 函數的行
        if f"{scene}/start" in line and "positioned" in line:
            return i, line

    return None, None


def update_coordinate(line: str, x: int, y: int, z: int) -> str:
    """替換行內的 positioned 座標"""
    return POSITIONED_RE.sub(rf"\g<1>{x} {y} {z}\3", line)


def main():
    apply = "--apply" in sys.argv
    changes = []
    skipped = []
    errors = []

    for key, coords in TRIGGER_COORDS.items():
        if coords is None:
            skipped.append(key)
            continue

        chapter = key.split("/")[0]
        trigger_file = FUNCTIONS_DIR / chapter / "trigger.mcfunction"

        if not trigger_file.exists():
            errors.append(f"  找不到 {trigger_file.relative_to(PROJECT_ROOT)}")
            continue

        line_idx, old_line = find_trigger_line(trigger_file, key)
        if old_line is None:
            errors.append(f"  在 {chapter}/trigger.mcfunction 中找不到 {key} 的座標觸發行")
            continue

        x, y, z = coords
        new_line = update_coordinate(old_line, x, y, z)

        if old_line == new_line:
            continue  # 座標相同，不需更新

        changes.append({
            "file": trigger_file,
            "line_idx": line_idx,
            "old": old_line.strip(),
            "new": new_line.strip(),
            "key": key,
        })

    # ── 輸出報告 ──
    print("=" * 60)
    print("觸發點座標更新工具")
    print("=" * 60)

    if skipped:
        print(f"\n跳過（座標未確認，共 {len(skipped)} 個）：")
        for s in skipped:
            print(f"  - {s}")

    if errors:
        print(f"\n錯誤（共 {len(errors)} 個）：")
        for e in errors:
            print(e)

    if not changes:
        print("\n沒有需要更新的座標。")
        return

    print(f"\n需要更新的座標（共 {len(changes)} 個）：")
    for c in changes:
        rel_path = c["file"].relative_to(PROJECT_ROOT)
        print(f"\n  [{c['key']}] {rel_path} 第 {c['line_idx'] + 1} 行")
        print(f"    舊: ...positioned {_extract_coords(c['old'])}...")
        print(f"    新: ...positioned {_extract_coords(c['new'])}...")

    if not apply:
        print("\n以上為預覽，加上 --apply 參數以套用變更。")
        return

    # ── 套用變更 ──
    # 按檔案分組
    by_file = {}
    for c in changes:
        by_file.setdefault(c["file"], []).append(c)

    for fpath, file_changes in by_file.items():
        lines = fpath.read_text(encoding="utf-8").splitlines(keepends=True)
        for c in file_changes:
            # 重新計算 new_line 以保留原始換行符
            old = lines[c["line_idx"]]
            x, y, z = TRIGGER_COORDS[c["key"]]
            lines[c["line_idx"]] = update_coordinate(old, x, y, z)
        fpath.write_text("".join(lines), encoding="utf-8")

    print(f"\n已套用 {len(changes)} 項變更。")


def _extract_coords(line: str) -> str:
    """從行內提取 positioned 後的座標供顯示"""
    m = POSITIONED_RE.search(line)
    return m.group(2) if m else "?"


if __name__ == "__main__":
    main()
