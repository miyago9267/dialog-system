"""
generate_actions.py  — 讀取 action stub 描述，產生 AJ 動畫 + 攝影機指令
用法:
    python tools/generate_actions.py [--dry-run]
"""
from __future__ import annotations
import argparse, glob, os, re, json, sys, io
from pathlib import Path

# Fix Windows cp932 encoding issues
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")
sys.stderr = io.TextIOWrapper(sys.stderr.buffer, encoding="utf-8", errors="replace")

BASE = Path(__file__).resolve().parent.parent  # datapacks/dialogtest
FUNC = BASE / "data" / "dialogtest" / "functions"

# ── Character mappings ─────────────────────────────────────────────
CHAR_VARIANT = {
    "尤尼恩":     ("union",     "union"),
    "阿多賽忒喀": ("firegod",  "firegod"),
    "火神":       ("firegod",  "firegod"),
    "奈迪拉提雅": ("watergod", "watergod"),
    "水神":       ("watergod", "watergod"),
    "麥洛倪雅莎": ("woodgod",  "woodgod"),
    "木神":       ("woodgod",  "woodgod"),
    "賽芬妲斯特": ("lightgod", "lightgod"),
    "光神":       ("lightgod", "lightgod"),
    "米迦爾":     ("migale",    "migale"),
    "彌賽邇":     ("migale",    "migale"),     # alias
    "鐵匠賽克":   (None,        None),         # villager, not AJ
    "莎琳瑟芬":   ("shalinsi",  "shalinsi"),
    "菲恩特":     ("phient",    "phient"),
    "阿帝嘉":     ("adrelie",   "adrelie"),
}

# ── Action keyword → AJ animation ─────────────────────────────────
ACTION_KEYWORDS = [
    # order matters: more specific first
    ("向主角鞠躬",   "bow"),
    ("鞠躬",         "bow"),
    ("向主角揮手",   "wavehand"),
    ("揮手",         "wavehand"),
    ("搖頭",         "shakehead"),
    ("點頭",         "nod"),
    ("抬手",         "give"),
    ("舉手",         "give"),
    ("伸手",         "give"),
    ("指向",         "give"),
    ("撥開",         "kick"),
    ("歪頭",         "sidehead"),
    ("原地跳躍",     "jumpinplace"),
    ("原地跳",       "jumpinplace"),
]

# Scenes whose start.mcfunction is hand-crafted — skip action generation
HAND_CRAFTED = {"fire/fire1", "fire/fire2"}

# Default duration (ticks) before resetting animation back to breath
ANIM_DURATION = 30


def parse_summon_todo(line: str):
    """Parse '# TODO: summon NAME at X Y Z (facing ...)' → dict or None."""
    m = re.match(
        r"#\s*TODO:\s*summon\s+(.+?)\s+at\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s*(?:\((.+?)\))?",
        line.strip()
    )
    if not m:
        return None
    name = m.group(1).rstrip("從")  # e.g. "米迦爾從" → "米迦爾"
    return {
        "name": name,
        "x": int(m.group(2)),
        "y": int(m.group(3)),
        "z": int(m.group(4)),
        "facing_hint": m.group(5) or "",
    }


def parse_player_tp(line: str):
    """Parse 'tp @a X Y Z facing FX FY FZ' → dict."""
    m = re.match(
        r"tp\s+@a\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)\s+facing\s+(-?\d+)\s+(-?\d+)\s+(-?\d+)",
        line.strip()
    )
    if not m:
        return None
    return {
        "x": int(m.group(1)), "y": int(m.group(2)), "z": int(m.group(3)),
        "fx": int(m.group(4)), "fy": int(m.group(5)), "fz": int(m.group(6)),
    }


def parse_stub(path: Path):
    """Parse an act*.mcfunction stub → action description + timing."""
    lines = path.read_text(encoding="utf-8").splitlines()
    desc = ""
    t = 0
    dialogue = ""
    for line in lines:
        m = re.match(r"#\s*動作：(.+)", line)
        if m:
            desc = m.group(1).strip()
        m = re.match(r"#\s*觸發時機：t=(\d+)", line)
        if m:
            t = int(m.group(1))
        m = re.match(r"#\s*對應台詞：(.+)", line)
        if m:
            dialogue = m.group(1).strip()
    return {"desc": desc, "t": t, "dialogue": dialogue, "path": path}


def detect_character(desc: str, characters: list[dict] | None = None) -> tuple[str | None, str | None]:
    """Detect which character performs the action from description."""
    # Camera-first: descriptions starting with camera keywords
    camera_prefixes = ["特寫", "主角視角", "視角", "回到初始", "回到", "退回", "黑畫面"]
    for prefix in camera_prefixes:
        if desc.startswith(prefix):
            return "__player__", "__player__"

    # Find earliest character name mention (prefer longer names for same position)
    matches = []
    for name, (variant, tag) in CHAR_VARIANT.items():
        if variant is None:
            continue
        pos = desc.find(name)
        if pos >= 0:
            matches.append((pos, -len(name), name, variant, tag))

    if matches:
        matches.sort()
        _, _, name, variant, tag = matches[0]
        # If union is the only match and not at position 0, prefer scene's main character
        if tag == "union" and matches[0][0] > 0 and characters:
            for char in characters:
                info = CHAR_VARIANT.get(char["name"])
                if info and info[0] and info[1] != "union":
                    return info
        return variant, tag

    # Fallback camera keywords (not at start)
    if any(k in desc for k in ["特寫", "視角", "回到", "退回"]):
        return "__player__", "__player__"

    # Fallback: use main character from scene (non-union)
    if characters:
        for char in characters:
            info = CHAR_VARIANT.get(char["name"])
            if info and info[0] and info[1] != "union":
                return info

    return None, None


def detect_anim(desc: str) -> str | None:
    """Detect AJ animation from description keywords."""
    for keyword, anim in ACTION_KEYWORDS:
        if keyword in desc:
            return anim
    return None


def is_look_action(desc: str) -> bool:
    """Check if action is a look-at/face direction action."""
    return any(k in desc for k in ["看向", "特寫", "視角", "回到初始"])


COMPLEX_KEYWORDS = [
    "BOSS戰", "開啟BOSS", "消失", "粒子", "走向", "走去", "走來",
    "移動至", "移動到", "跑走", "離開",
    "黑畫面", "冒險系統", "門框", "開啟四道",
    "水晶施放", "水滴", "水聚集",
    "堯稚克幻象", "屍骸分身",
    "神權論", "階級論",
    "中庭鎮守", "沙壁村",
    "戰利品箱",
]


def is_complex(desc: str) -> bool:
    """Check if action is too complex (BOSS, particles, walk+move, etc.)."""
    return any(k in desc for k in COMPLEX_KEYWORDS)


def is_pure_complex(desc: str) -> bool:
    """Complex with NO extractable AJ animation at all."""
    if not is_complex(desc):
        return False
    # If there's also an AJ animation keyword, it's not pure complex
    anim = detect_anim(desc)
    return anim is None


def extract_facing_coords(desc: str):
    """Extract coordinates from descriptions like '看向-1775 82 2112'."""
    m = re.search(r"(-?\d+)\s+(\d+)\s+(-?\d+)", desc)
    if m:
        return int(m.group(1)), int(m.group(2)), int(m.group(3))
    return None


def generate_summon_cmds(char_info: dict, scene_tag: str, player_tp: dict | None,
                         all_characters: list[dict] | None = None):
    """Generate AJ summon commands for a character."""
    name = char_info["name"]
    info = CHAR_VARIANT.get(name)
    if not info or info[0] is None:
        return []
    variant, tag = info
    x, y, z = char_info["x"], char_info["y"], char_info["z"]
    facing_hint = char_info["facing_hint"]

    cmds = []

    # Determine facing
    facing = ""
    if "面向主角" in facing_hint and player_tp:
        facing = f"facing {player_tp['x']} {player_tp['y']} {player_tp['z']}"
    elif "面向前方" in facing_hint:
        facing = ""  # use default rotation
    elif "面向" in facing_hint:
        coords = extract_facing_coords(facing_hint)
        if coords:
            facing = f"facing {coords[0]} {coords[1]} {coords[2]}"
        elif all_characters:
            # Resolve character name in facing hint
            for other in all_characters:
                if other["name"] != name and other["name"] in facing_hint:
                    facing = f"facing {other['x']} {other['y']} {other['z']}"
                    break
            if not facing:
                # Try short names from CHAR_VARIANT
                for cname, (cv, ct) in CHAR_VARIANT.items():
                    if cname != name and cname in facing_hint and cv:
                        for other in all_characters:
                            oi = CHAR_VARIANT.get(other["name"])
                            if oi and oi[1] == ct:
                                facing = f"facing {other['x']} {other['y']} {other['z']}"
                                break
                        if facing:
                            break

    # Summon AJ character
    if facing:
        cmds.append(
            f"execute positioned {x} {y} {z} {facing} "
            f"run function animated_java:character/summon {{args: {{variant: '{variant}'}}}}"
        )
    else:
        cmds.append(
            f"execute positioned {x} {y} {z} "
            f"run function animated_java:character/summon {{args: {{variant: '{variant}'}}}}"
        )
    cmds.append(
        f"execute positioned {x} {y} {z} run tag @e[sort=nearest,limit=1,tag=aj.character.root] add {tag}"
    )

    # Name display entity (text_display with billboard for visibility)
    cmds.append(
        f'summon text_display {x} {y + 3} {z} '
        f'{{text:\'{{"text":"{name}","color":"white","bold":true}}\','
        f'billboard:"center",Tags:["{scene_tag}"]}}'
    )

    return cmds


def generate_cleanup_cmds(characters: list[dict], scene_tag: str):
    """Generate cleanup commands for removing AJ characters."""
    cmds = []
    cmds.append("# 解除玩家鎖定")
    cmds.append("effect clear @a slowness")
    cmds.append("effect clear @a jump_boost")
    cmds.append("")

    # Remove AJ characters
    aj_tags = set()
    for char in characters:
        name = char["name"]
        info = CHAR_VARIANT.get(name)
        if info and info[0] is not None:
            _, tag = info
            aj_tags.add(tag)

    if aj_tags:
        cmds.append("# 移除 AJ 角色")
        for tag in sorted(aj_tags):
            cmds.append(f"execute as @e[tag={tag}] run function animated_java:character/remove/this")
        cmds.append("")

    # Kill scene entities (name displays etc.)
    cmds.append("# 清除場景實體")
    cmds.append(f"kill @e[tag={scene_tag}]")
    cmds.append("")

    cmds.append("# 結束時間軸")
    cmds.append("data modify storage dialogtest:story run.playing set value 0b")
    cmds.append("data remove storage dialogtest:story run.mode")

    return cmds


def process_scene(scene_path: str, dry_run: bool):
    """
    Process a single scene directory.
    scene_path: relative path like 'water/water1'
    """
    scene_dir = FUNC / scene_path
    start_file = scene_dir / "start.mcfunction"

    if not start_file.exists():
        return

    # Read start.mcfunction
    start_content = start_file.read_text(encoding="utf-8")
    start_lines = start_content.splitlines()

    # Parse TODO summon comments
    characters = []
    player_tp = None
    for line in start_lines:
        s = parse_summon_todo(line)
        if s:
            characters.append(s)
        p = parse_player_tp(line)
        if p:
            player_tp = p

    if not characters:
        print(f"  SKIP {scene_path}: no TODO summon found")
        return

    # Find action stubs
    stubs = []
    for f in sorted(scene_dir.glob("act*.mcfunction")):
        if f.name.startswith("act"):
            stubs.append(parse_stub(f))

    if not stubs:
        print(f"  SKIP {scene_path}: no action stubs")
        return

    # Determine scene tag
    scene_id = scene_path.split("/")[-1]
    scene_tag = f"{scene_id}_entity"

    # Generate action track events
    action_events = []
    fn_stubs_to_write = {}  # filename → content lines

    for stub in stubs:
        desc = stub["desc"]
        t = stub["t"]
        stub_name = stub["path"].stem  # e.g. "act1"

        variant, tag = detect_character(desc, characters)
        anim = detect_anim(desc)

        # ── Pure complex (no AJ animation extractable) ──
        if is_pure_complex(desc):
            fn_name = f"dialogtest:{scene_path}/{stub_name}"
            action_events.append(f'{{t:{t},type:"fn",fn:"{fn_name}"}}')
            print(f"    {stub_name} (t={t}): COMPLEX skip -- {desc}")
            continue

        # ── AJ animation (possibly with complex parts or look-at) ──
        if anim and tag and tag != "__player__":
            # Inline anim_trs events
            action_events.append(
                f'{{t:{t},type:"anim_trs",tag:"{tag}",from:"breath",to:"{anim}"}}'
            )
            action_events.append(
                f'{{t:{t + ANIM_DURATION},type:"anim_trs",tag:"{tag}",from:"{anim}",to:"breath"}}'
            )

            extra = ""
            # Also add look-at fn if needed
            if "看向主角" in desc or "看向玩家" in desc:
                fn_name = f"dialogtest:{scene_path}/{stub_name}"
                action_events.append(f'{{t:{t},type:"fn",fn:"{fn_name}"}}')
                fn_lines = [
                    f"# {desc}",
                    f"execute as @e[tag={tag}] at @s run tp @s ~ ~ ~ facing @a[sort=nearest,limit=1]",
                ]
                fn_stubs_to_write[stub_name] = fn_lines
                extra = " + face player"
            elif "看向尤尼恩" in desc:
                fn_name = f"dialogtest:{scene_path}/{stub_name}"
                action_events.append(f'{{t:{t},type:"fn",fn:"{fn_name}"}}')
                fn_lines = [
                    f"# {desc}",
                    f"execute as @e[tag={tag}] at @s run tp @s ~ ~ ~ facing @e[tag=union,limit=1]",
                ]
                fn_stubs_to_write[stub_name] = fn_lines
                extra = " + face union"
            elif "背對" in desc:
                fn_name = f"dialogtest:{scene_path}/{stub_name}"
                action_events.append(f'{{t:{t},type:"fn",fn:"{fn_name}"}}')
                fn_lines = [f"# {desc}"]
                if player_tp:
                    for ch in characters:
                        if CHAR_VARIANT.get(ch["name"], (None, None))[1] == tag:
                            cx, cy, cz = ch["x"], ch["y"], ch["z"]
                            dx = cx - player_tp["x"]
                            dz = cz - player_tp["z"]
                            fn_lines.append(
                                f"execute as @e[tag={tag}] at @s run tp @s ~ ~ ~ facing {cx + dx} {cy} {cz + dz}"
                            )
                            break
                fn_stubs_to_write[stub_name] = fn_lines
                extra = " + face away"

            complex_note = " (+ complex TODO)" if is_complex(desc) else ""
            print(f"    {stub_name} (t={t}): {anim} on {tag}{extra}{complex_note} -- {desc}")
            continue

        # ── Player camera actions ──
        if tag == "__player__":
            fn_name = f"dialogtest:{scene_path}/{stub_name}"
            action_events.append(f'{{t:{t},type:"fn",fn:"{fn_name}"}}')

            fn_lines = [f"# {desc}"]

            if "特寫" in desc:
                # Camera close-up: find character being featured
                found = False
                for cname, (cv, ct) in CHAR_VARIANT.items():
                    if cv and cname in desc:
                        for ch in characters:
                            if ch["name"] == cname:
                                cx, cy, cz = ch["x"], ch["y"], ch["z"]
                                # Position player 2 blocks closer, facing the character
                                if player_tp:
                                    # Midpoint between player and character
                                    mx = (player_tp["x"] + cx) // 2
                                    mz = (player_tp["z"] + cz) // 2
                                    fn_lines.append(f"tp @a {mx} {cy} {mz} facing {cx} {cy} {cz}")
                                else:
                                    fn_lines.append(f"tp @a {cx} {cy} {cz - 2} facing {cx} {cy} {cz}")
                                found = True
                                break
                        if found:
                            break
                if not found:
                    fn_lines.append("# TODO: implement close-up target")
                print(f"    {stub_name} (t={t}): camera close-up -- {desc}")

            elif "回到初始" in desc or "退回" in desc or "回到" in desc:
                if player_tp:
                    fn_lines.append(
                        f"tp @a {player_tp['x']} {player_tp['y']} {player_tp['z']} "
                        f"facing {player_tp['fx']} {player_tp['fy']} {player_tp['fz']}"
                    )
                print(f"    {stub_name} (t={t}): camera reset -- {desc}")

            elif "視角" in desc or "看向" in desc:
                coords = extract_facing_coords(desc)
                if coords:
                    fx, fy, fz = coords
                    if player_tp:
                        fn_lines.append(
                            f"tp @a {player_tp['x']} {player_tp['y']} {player_tp['z']} "
                            f"facing {fx} {fy} {fz}"
                        )
                    else:
                        fn_lines.append(f"tp @a ~ ~ ~ facing {fx} {fy} {fz}")
                print(f"    {stub_name} (t={t}): camera look-at -- {desc}")

            else:
                fn_lines.append("# TODO: implement camera action")
                print(f"    {stub_name} (t={t}): camera TODO -- {desc}")

            fn_stubs_to_write[stub_name] = fn_lines
            continue

        # ── Character look-at without animation ──
        if is_look_action(desc) and tag:
            fn_name = f"dialogtest:{scene_path}/{stub_name}"
            action_events.append(f'{{t:{t},type:"fn",fn:"{fn_name}"}}')
            fn_lines = [f"# {desc}"]
            if "看向主角" in desc or "看向玩家" in desc:
                fn_lines.append(
                    f"execute as @e[tag={tag}] at @s run tp @s ~ ~ ~ facing @a[sort=nearest,limit=1]"
                )
            elif "背對" in desc:
                if player_tp:
                    for ch in characters:
                        if CHAR_VARIANT.get(ch["name"], (None, None))[1] == tag:
                            cx, cy, cz = ch["x"], ch["y"], ch["z"]
                            dx = cx - player_tp["x"]
                            dz = cz - player_tp["z"]
                            fn_lines.append(
                                f"execute as @e[tag={tag}] at @s run tp @s ~ ~ ~ facing {cx + dx} {cy} {cz + dz}"
                            )
                            break
            fn_stubs_to_write[stub_name] = fn_lines
            print(f"    {stub_name} (t={t}): look-at on {tag} -- {desc}")
            continue

        # ── Fallback: keep as TODO fn stub ──
        fn_name = f"dialogtest:{scene_path}/{stub_name}"
        action_events.append(f'{{t:{t},type:"fn",fn:"{fn_name}"}}')
        print(f"    {stub_name} (t={t}): UNKNOWN skip -- {desc}")

    # ── Build updated start.mcfunction ──────────────────────────────

    new_lines = []
    skip_next_action_comment = False

    for i, line in enumerate(start_lines):
        stripped = line.strip()

        # Replace TODO summon with actual summon
        if stripped.startswith("# TODO: summon"):
            # Only add summon commands when we hit the FIRST TODO summon
            if not any(l.strip().startswith("# TODO: summon") for l in start_lines[:i]):
                # First TODO — add all summon commands
                for char in characters:
                    cmds = generate_summon_cmds(char, scene_tag, player_tp, characters)
                    for cmd in cmds:
                        new_lines.append(cmd)
                    if cmds:
                        new_lines.append("")
            # Skip this TODO line (all subsequent ones too)
            continue

        # Replace disabled action track
        if "# [DISABLED] action" in stripped:
            if action_events:
                new_lines.append("# action 軌（AJ 動畫與攝影機動作）")
                # Sort events by t value (timeline advance requires sorted order)
                def sort_key(e):
                    m = re.search(r't:(\d+)', e)
                    return int(m.group(1)) if m else 0
                action_events.sort(key=sort_key)
                events_str = ",".join(action_events)
                new_lines.append(
                    f"data modify storage dialogtest:story run.action set value [{events_str}]"
                )
                # Add action descriptions as comments
                for stub in stubs:
                    stub_name = stub["path"].stem
                    new_lines.append(f"# {stub_name} (t={stub['t']}): {stub['desc']}")
                new_lines.append("")
            skip_next_action_comment = True
            continue

        if skip_next_action_comment and stripped.startswith("# data modify"):
            continue
        if skip_next_action_comment and stripped.startswith("# act"):
            continue
        if skip_next_action_comment and stripped == "":
            skip_next_action_comment = False
            # Don't add the blank line, we already added one
            continue

        new_lines.append(line)

    # ── Build updated cleanup.mcfunction ────────────────────────────
    cleanup_file = scene_dir / "cleanup.mcfunction"
    cleanup_lines = []
    scene_label = scene_path.replace("/", " ")
    cleanup_lines.append(f"# {scene_id} 場景清理（ctrl 軌觸發）")
    cleanup_lines.append("")
    cleanup_lines.extend(generate_cleanup_cmds(characters, scene_tag))

    # ── Write files ─────────────────────────────────────────────────
    if dry_run:
        print(f"\n  [DRY-RUN] Would write {start_file.name}:")
        for line in new_lines[:5]:
            print(f"    {line}")
        print(f"    ... ({len(new_lines)} lines total)")
        print(f"  [DRY-RUN] Would write cleanup.mcfunction ({len(cleanup_lines)} lines)")
        for name, content in fn_stubs_to_write.items():
            print(f"  [DRY-RUN] Would write {name}.mcfunction ({len(content)} lines)")
    else:
        start_file.write_text("\n".join(new_lines) + "\n", encoding="utf-8")
        cleanup_file.write_text("\n".join(cleanup_lines) + "\n", encoding="utf-8")
        for name, content in fn_stubs_to_write.items():
            stub_file = scene_dir / f"{name}.mcfunction"
            stub_file.write_text("\n".join(content) + "\n", encoding="utf-8")

    n_inline = sum(1 for e in action_events if "anim_trs" in e) // 2
    n_fn = sum(1 for e in action_events if '"fn"' in e)
    print(f"  => {scene_path}: {n_inline} inline anims, {n_fn} fn calls, "
          f"{len(fn_stubs_to_write)} stubs written")


def find_scenes_with_stubs():
    """Find all scene directories containing act*.mcfunction files."""
    scenes = set()
    for f in FUNC.rglob("act*.mcfunction"):
        # e.g. functions/water/water1/act1.mcfunction → water/water1
        rel = f.parent.relative_to(FUNC)
        scene = str(rel).replace("\\", "/")
        scenes.add(scene)
    return sorted(scenes)


def main():
    parser = argparse.ArgumentParser(description="Generate AJ action implementations")
    parser.add_argument("--dry-run", action="store_true", help="Preview without writing")
    parser.add_argument("--scenes", type=str, help="Comma-separated scene paths to process")
    args = parser.parse_args()

    scenes = find_scenes_with_stubs()
    if args.scenes:
        filter_set = set(args.scenes.split(","))
        scenes = [s for s in scenes if s in filter_set]

    print(f"Found {len(scenes)} scenes with action stubs")
    print()

    stats = {"inline": 0, "fn": 0, "skip": 0}

    for scene in scenes:
        if scene in HAND_CRAFTED:
            print(f"  SKIP {scene}: hand-crafted (preserved)")
            continue
        print(f"Processing {scene}...")
        process_scene(scene, args.dry_run)
        print()

    print("Done!")


if __name__ == "__main__":
    main()
