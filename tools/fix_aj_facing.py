"""
修正 AJ 角色初始朝向問題。

AJ 的 summon 函數不吃 execute 的 rotation context，
所以在 summon + tag 之後加一行 tp 強制設定朝向。

模式：
  execute positioned X Y Z facing FX FY FZ run function animated_java:character/summon ...
  execute positioned X Y Z run tag @e[...] add TAG
  → 插入: execute as @e[tag=TAG] at @s run tp @s ~ ~ ~ facing FX FY FZ

  execute positioned X Y Z rotated RY RX run function animated_java:character/summon ...
  execute positioned X Y Z run tag @e[...] add TAG
  → 插入: execute as @e[tag=TAG] at @s run tp @s ~ ~ ~ RY RX
"""

import re, sys, io, pathlib

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

FUNCS = pathlib.Path(r"c:\Users\miyago\AppData\Roaming\PrismLauncher\instances\endofmemories\minecraft\saves\end_of_memories_map\datapacks\dialogtest\data\dialogtest\functions")

# summon with facing
SUMMON_FACING = re.compile(
    r'^execute positioned [\d\-\.]+ [\d\-\.]+ [\d\-\.]+ facing ([\d\-\.]+ [\d\-\.]+ [\d\-\.]+) run function animated_java:character/summon'
)
# summon with rotated
SUMMON_ROTATED = re.compile(
    r'^execute positioned [\d\-\.]+ [\d\-\.]+ [\d\-\.]+ rotated ([\d\-\.]+ [\d\-\.]+) run function animated_java:character/summon'
)
# tag line
TAG_PAT = re.compile(
    r'^execute positioned [\d\-\.]+ [\d\-\.]+ [\d\-\.]+ run tag @e\[sort=nearest,limit=1,tag=aj\.character\.root\] add (\w+)'
)
# already-existing tp fix
TP_FIX_PAT = re.compile(
    r'^execute as @e\[tag=\w+\] at @s run tp @s ~ ~ ~ '
)

changed_files = 0

for mcf in sorted(FUNCS.rglob("start.mcfunction")):
    lines = mcf.read_text(encoding="utf-8").splitlines(keepends=True)
    new_lines = []
    file_changed = False
    i = 0

    while i < len(lines):
        line = lines[i]
        stripped = line.strip()

        facing_m = SUMMON_FACING.match(stripped)
        rotated_m = SUMMON_ROTATED.match(stripped)

        if facing_m or rotated_m:
            new_lines.append(line)
            # next line should be the tag line
            if i + 1 < len(lines):
                tag_line = lines[i + 1]
                tag_m = TAG_PAT.match(tag_line.strip())
                if tag_m:
                    tag = tag_m.group(1)
                    new_lines.append(tag_line)
                    i += 2

                    # skip if tp fix already exists
                    if i < len(lines) and TP_FIX_PAT.match(lines[i].strip()):
                        continue

                    # build tp line
                    if facing_m:
                        coords = facing_m.group(1)
                        tp = f"execute as @e[tag={tag}] at @s run tp @s ~ ~ ~ facing {coords}\n"
                    else:
                        rot = rotated_m.group(1)
                        tp = f"execute as @e[tag={tag}] at @s run tp @s ~ ~ ~ {rot}\n"

                    new_lines.append(tp)
                    file_changed = True
                    continue
            # fallthrough if no tag line found
            i += 1
        else:
            new_lines.append(line)
            i += 1

    if file_changed:
        mcf.write_text("".join(new_lines), encoding="utf-8")
        changed_files += 1
        print(f"  [OK] {mcf.relative_to(FUNCS)}")

print(f"\n完成: {changed_files} 個檔案")
