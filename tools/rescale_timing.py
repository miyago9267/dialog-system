"""
將所有場景的時間軸間隔從 60 ticks 改為 100 ticks。

公式：new_t = 25 + ((t - 25) // 60) * 100 + ((t - 25) % 60)

即：保持行內偏移不變，只拉大行與行之間的距離。
"""

import re, sys, io, pathlib

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

OLD_INTERVAL = 60
NEW_INTERVAL = 100
BASE = 25  # 第一行起始 tick

FUNCS = pathlib.Path(r"c:\Users\miyago\AppData\Roaming\PrismLauncher\instances\endofmemories\minecraft\saves\end_of_memories_map\datapacks\dialogtest\data\dialogtest\functions")

# 匹配 timeline data 行
TIMELINE_PAT = re.compile(r'^(data modify storage dialogtest:story run\.\w+ set value \[.+\])$')
T_PAT = re.compile(r't:(\d+)')


def rescale_t(match):
    old_t = int(match.group(1))
    if old_t < BASE:
        return match.group(0)  # t < 25 不動
    slot = (old_t - BASE) // OLD_INTERVAL
    offset = (old_t - BASE) % OLD_INTERVAL
    new_t = BASE + slot * NEW_INTERVAL + offset
    return f"t:{new_t}"


changed_files = 0
total_lines_changed = 0

for mcf in sorted(FUNCS.rglob("start.mcfunction")):
    lines = mcf.read_text(encoding="utf-8").splitlines(keepends=True)
    new_lines = []
    file_changed = False
    for line in lines:
        stripped = line.strip()
        if TIMELINE_PAT.match(stripped):
            new_line = T_PAT.sub(rescale_t, line)
            if new_line != line:
                file_changed = True
                total_lines_changed += 1
            new_lines.append(new_line)
        else:
            new_lines.append(line)
    if file_changed:
        mcf.write_text("".join(new_lines), encoding="utf-8")
        changed_files += 1
        print(f"  [OK] {mcf.relative_to(FUNCS)}")

print(f"\n完成: {changed_files} 個檔案, {total_lines_changed} 行修改")
