"""
修正動畫轉場時長：
- nod: 30 ticks → 20 ticks (loop, 20 frames = 1 cycle)
- bow: 30 ticks → 100 ticks (stop, 100 frames)
"""

import re, sys, io, pathlib

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

FUNCS = pathlib.Path(r"c:\Users\miyago\AppData\Roaming\PrismLauncher\instances\endofmemories\minecraft\saves\end_of_memories_map\datapacks\dialogtest\data\dialogtest\functions")

# 動畫正確時長 (只修有問題的)
ANIM_DURATION = {
    "nod": 20,
    "bow": 100,
}

changed_files = 0
fixes = []

for mcf in sorted(FUNCS.rglob("start.mcfunction")):
    text = mcf.read_text(encoding="utf-8")
    original = text

    for anim, correct_dur in ANIM_DURATION.items():
        # 找到 to:"<anim>" 的 t 值，然後找對應的 from:"<anim>",to:"breath" 並修正 t 值
        # Pattern: {t:X,...,to:"<anim>"} ... {t:Y,...,from:"<anim>",to:"breath"}
        starts = [(m.start(), int(m.group(1))) for m in re.finditer(rf'\{{t:(\d+),[^}}]*to:"{anim}"\}}', text)]

        for _, start_t in starts:
            # 找到對應的 from:"<anim>",to:"breath" 並修正
            end_pat = re.compile(rf'\{{t:(\d+),type:"anim_trs",[^}}]*from:"{anim}",to:"breath"\}}')
            for m in end_pat.finditer(text):
                end_t = int(m.group(1))
                expected_end = start_t + correct_dur
                if end_t != expected_end and end_t == start_t + 30:  # 只修 30-tick 的錯誤
                    old = m.group(0)
                    new = old.replace(f"t:{end_t}", f"t:{expected_end}")
                    text = text.replace(old, new, 1)
                    fixes.append(f"  {mcf.name}: {anim} t:{start_t}→{start_t+correct_dur} (was {end_t})")
                    break  # 每個 start 只配一個 end

    if text != original:
        mcf.write_text(text, encoding="utf-8")
        changed_files += 1

for f in fixes:
    print(f)
print(f"\n完成: {changed_files} 個檔案, {len(fixes)} 處修正")
