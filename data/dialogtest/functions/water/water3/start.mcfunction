# 設置已觸發，防止重複執行
scoreboard players set water3_triggered water_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true
effect give @a blindness 1 0 true

execute positioned -1749 14 1592 facing -1750 12 1575 run function animated_java:character/summon {args: {variant: 'watergod'}}
execute positioned -1749 14 1592 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add watergod
summon text_display -1749 16 1592 {text:'{"text":"奈迪拉提雅","color":"white","bold":true}',billboard:"center",Tags:["water3_entity"]}

execute positioned -1748 12 1576 facing -1749 14 1592 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1748 12 1576 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon text_display -1748 14 1576 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["water3_entity"]}

tp @a -1750 12 1575 facing -1749 14 1592

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.water.water3.line1"},{t:60,type:"text",key:"story.water.water3.line2"},{t:120,type:"text",key:"story.water.water3.line3"},{t:180,type:"text",key:"story.water.water3.line4"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:0,type:"anim_trs",tag:"watergod",from:"breath",to:"give"},{t:30,type:"anim_trs",tag:"watergod",from:"give",to:"breath"},{t:60,type:"anim_trs",tag:"watergod",from:"breath",to:"nod"},{t:90,type:"anim_trs",tag:"watergod",from:"nod",to:"breath"},{t:120,type:"anim_trs",tag:"watergod",from:"breath",to:"kick"},{t:150,type:"anim_trs",tag:"watergod",from:"kick",to:"breath"},{t:180,type:"fn",fn:"dialogtest:water/water3/act4"}]
# act1 (t=0): 奈迪拉提雅舉手
# act2 (t=60): 奈迪拉提雅點頭
# act3 (t=120): 奈迪拉提雅撥開
# act4 (t=180): 奈迪拉提雅變成水滴與水波直線移動到場地中央並開啟BOSS戰

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:240,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "water_water3"
data modify storage dialogtest:story run.scene_tick set value 0
