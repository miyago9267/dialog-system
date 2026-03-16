"""
修正 scene_camera marker 的初始朝向。

問題：summon marker 不帶 Rotation NBT，預設 yaw=0（南方）。
     tp 修正朝向可能在同 tick 內對 execute at 無效。

修法：從 tp facing 指令計算 yaw/pitch，嵌入 summon 的 Rotation NBT。
"""

import re, sys, io, pathlib, math

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

FUNCS = pathlib.Path(r"c:\Users\miyago\AppData\Roaming\PrismLauncher\instances\endofmemories\minecraft\saves\end_of_memories_map\datapacks\dialogtest\data\dialogtest\functions")

SUMMON_PAT = re.compile(
    r'^(summon marker) ([\d\-\.]+) ([\d\-\.]+) ([\d\-\.]+) (\{Tags:\["scene_camera"\]\})'
)
TP_PAT = re.compile(
    r'^execute as @e\[tag=scene_camera\] at @s run tp @s ~ ~ ~ facing ([\d\-\.]+) ([\d\-\.]+) ([\d\-\.]+)'
)


def calc_rotation(sx, sy, sz, fx, fy, fz):
    """Calculate Minecraft yaw and pitch from source to facing target."""
    dx = fx - sx
    dy = fy - sy
    dz = fz - sz
    # yaw: 0=south(+Z), 90=west(-X), 180=north(-Z), 270=east(+X)
    yaw = -math.atan2(dx, dz) * (180.0 / math.pi)
    # pitch: 0=straight, -90=up, 90=down
    horiz = math.sqrt(dx * dx + dz * dz)
    pitch = -math.atan2(dy, horiz) * (180.0 / math.pi)
    return round(yaw, 1), round(pitch, 1)


changed = 0

for mcf in sorted(FUNCS.rglob("start.mcfunction")):
    text = mcf.read_text(encoding="utf-8")
    lines = text.splitlines(keepends=True)
    new_lines = []
    file_changed = False
    i = 0

    while i < len(lines):
        line = lines[i]
        stripped = line.strip()
        sm = SUMMON_PAT.match(stripped)

        if sm:
            sx, sy, sz = float(sm.group(2)), float(sm.group(3)), float(sm.group(4))
            # Look ahead for the tp facing line
            if i + 1 < len(lines):
                tp_line = lines[i + 1].strip()
                tm = TP_PAT.match(tp_line)
                if tm:
                    fx, fy, fz = float(tm.group(1)), float(tm.group(2)), float(tm.group(3))
                    yaw, pitch = calc_rotation(sx, sy, sz, fx, fy, fz)
                    # Rebuild summon with Rotation
                    new_summon = f'summon marker {sm.group(2)} {sm.group(3)} {sm.group(4)} {{Rotation:[{yaw}f,{pitch}f],Tags:["scene_camera"]}}\n'
                    new_lines.append(new_summon)
                    # Keep the tp line as backup (it won't hurt)
                    new_lines.append(lines[i + 1])
                    i += 2
                    file_changed = True
                    scene = mcf.relative_to(FUNCS)
                    print(f"  [OK] {scene}: yaw={yaw}, pitch={pitch}")
                    continue

        new_lines.append(line)
        i += 1

    if file_changed:
        mcf.write_text("".join(new_lines), encoding="utf-8")
        changed += 1

print(f"\n完成: {changed} 個檔案")
