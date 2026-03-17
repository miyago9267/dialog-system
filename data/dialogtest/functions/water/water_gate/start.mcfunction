# 設置已觸發，防止重複執行
scoreboard players set water_gate_triggered water_story 1

# ── 場景設置 ──────────────────────────────────────────────
gamemode spectator @a

# 放置相機（面向水靈座大門 z=1558）
summon marker -1749 20 1541 {Rotation:[0.0f,6.7f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1749 18 1558
tp @a -1749 20 1541 facing -1749 18 1558

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.water.water_gate.line1"}]

# action 軌（粒子特效 + 音效 + 大門消除）
data modify storage dialogtest:story run.action set value [{t:25,type:"fn",fn:"dialogtest:water/water_gate/effect_start"},{t:105,type:"fn",fn:"dialogtest:water/water_gate/rune_remove"}]

# ctrl 軌
data modify storage dialogtest:story run.ctrl set value [{t:145,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:185,type:"fn",fn:"dialogtest:water/water_gate/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "water_water_gate"
data modify storage dialogtest:story run.scene_tick set value 0
