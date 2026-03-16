"""
修正所有 AJ 動畫的回歸時間，確保每個動畫完整播放後才回到 breath。

動畫時長表：
  nod: 20 ticks (loop, 1 cycle)
  bow: 100 ticks (stop)
  sidehead: 100 ticks (stop)
  give: 110 ticks (stop)
  kick: 10 ticks (stop)
  shakehead: 30 ticks (stop)
  wavehand: 35 ticks (stop)

規則：找到 {t:START, ..., to:"ANIM"} 和 {t:END, ..., from:"ANIM", to:"breath"}，
      把 END 修正為 START + ANIM_DURATION。
"""

import re, sys, io, pathlib, json

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

FUNCS = pathlib.Path(r"c:\Users\miyago\AppData\Roaming\PrismLauncher\instances\endofmemories\minecraft\saves\end_of_memories_map\datapacks\dialogtest\data\dialogtest\functions")

ANIM_DURATIONS = {
    'nod': 20,
    'bow': 100,
    'sidehead': 100,
    'give': 110,
    'kick': 10,
    'shakehead': 30,
    'wavehand': 35,
}

# Match individual event objects in the action track
EVENT_PAT = re.compile(r'\{[^}]+\}')
# Extract fields from an event
T_PAT = re.compile(r't:(\d+)')
TYPE_PAT = re.compile(r'type:"([^"]+)"')
TAG_PAT = re.compile(r'tag:"([^"]+)"')
FROM_PAT = re.compile(r'from:"([^"]+)"')
TO_PAT = re.compile(r'to:"([^"]+)"')

TIMELINE_PAT = re.compile(r'^data modify storage dialogtest:story run\.action set value \[(.+)\]$')

total_fixes = 0
fixed_files = []

for mcf in sorted(FUNCS.rglob("start.mcfunction")):
    text = mcf.read_text(encoding="utf-8")
    lines = text.splitlines(keepends=True)
    file_changed = False

    for li, line in enumerate(lines):
        stripped = line.strip()
        m = TIMELINE_PAT.match(stripped)
        if not m:
            continue

        # Parse all events
        events_str = m.group(1)
        events_raw = EVENT_PAT.findall(events_str)
        events = []
        for raw in events_raw:
            t = int(T_PAT.search(raw).group(1)) if T_PAT.search(raw) else None
            typ = TYPE_PAT.search(raw).group(1) if TYPE_PAT.search(raw) else None
            tag = TAG_PAT.search(raw).group(1) if TAG_PAT.search(raw) else None
            frm = FROM_PAT.search(raw).group(1) if FROM_PAT.search(raw) else None
            to = TO_PAT.search(raw).group(1) if TO_PAT.search(raw) else None
            events.append({'t': t, 'type': typ, 'tag': tag, 'from': frm, 'to': to, 'raw': raw})

        # Find start-end pairs: breath->ANIM then ANIM->breath (same tag)
        replacements = {}  # old_t -> new_t for end events
        for i, ev in enumerate(events):
            if ev['type'] != 'anim_trs' or ev['from'] != 'breath':
                continue
            anim = ev['to']
            if anim not in ANIM_DURATIONS or anim == 'breath':
                continue
            start_t = ev['t']
            tag = ev['tag']
            correct_end = start_t + ANIM_DURATIONS[anim]

            # Find the matching end event (same tag, from=anim, to=breath)
            for j in range(i + 1, len(events)):
                ej = events[j]
                if (ej['type'] == 'anim_trs' and ej['tag'] == tag
                        and ej['from'] == anim and ej['to'] == 'breath'):
                    if ej['t'] != correct_end:
                        old_frag = f't:{ej["t"]},type:"anim_trs",tag:"{tag}",from:"{anim}",to:"breath"'
                        new_frag = f't:{correct_end},type:"anim_trs",tag:"{tag}",from:"{anim}",to:"breath"'
                        replacements[old_frag] = new_frag
                        scene = mcf.relative_to(FUNCS)
                        print(f"  {scene}: {tag} {anim} t:{ej['t']} -> t:{correct_end} (duration {ANIM_DURATIONS[anim]})")
                        total_fixes += 1
                    break

        if replacements:
            new_line = line
            for old_frag, new_frag in replacements.items():
                new_line = new_line.replace(old_frag, new_frag)
            if new_line != line:
                lines[li] = new_line
                file_changed = True

    if file_changed:
        mcf.write_text("".join(lines), encoding="utf-8")
        fixed_files.append(mcf.relative_to(FUNCS))

print(f"\n完成: {len(fixed_files)} 個檔案, {total_fixes} 處修正")
