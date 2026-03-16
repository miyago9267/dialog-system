# 設置已觸發，防止重複執行
scoreboard players set water4_triggered water_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -1749 12 1582 facing -1750 12 1575 run function animated_java:character/summon {args: {variant: 'watergod'}}
execute positioned -1749 12 1582 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add watergod
execute as @e[tag=watergod] at @s run tp @s ~ ~ ~ facing -1750 12 1575
summon text_display -1749 14 1582 {text:'{"text":"奈迪拉提雅","color":"aqua","bold":true}',billboard:"center",Tags:["water4_entity"]}

execute positioned -1748 12 1576 facing -1749 12 1582 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1748 12 1576 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -1749 12 1582
summon text_display -1748 14 1576 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["water4_entity"]}

summon marker -1750 12 1575 {Rotation:[-8.1f,-0.0f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1749 12 1582
tp @a -1750 12 1575 facing -1749 12 1582

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.water.water4.line1"},{t:105,type:"text",key:"story.water.water4.line2"},{t:185,type:"text",key:"story.water.water4.line3"},{t:265,type:"text",key:"story.water.water4.line4"},{t:345,type:"text",key:"story.water.water4.line5"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:25,type:"anim_trs",tag:"watergod",from:"breath",to:"nod"},{t:45,type:"anim_trs",tag:"watergod",from:"nod",to:"breath"},{t:105,type:"anim_trs",tag:"watergod",from:"breath",to:"bow"},{t:205,type:"anim_trs",tag:"watergod",from:"bow",to:"breath"},{t:265,type:"anim_trs",tag:"watergod",from:"breath",to:"sidehead"},{t:265,type:"fn",fn:"dialogtest:water/water4/act3"},{t:365,type:"anim_trs",tag:"watergod",from:"sidehead",to:"breath"}]
# act1 (t=0): 奈迪拉提雅點頭
# act2 (t=60): 奈迪拉提雅向主角鞠躬
# act3 (t=180): 轉過頭背對主角與尤尼恩並歪頭

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:385,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:425,type:"fn",fn:"dialogtest:water/water4/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "water_water4"
data modify storage dialogtest:story run.scene_tick set value 0
