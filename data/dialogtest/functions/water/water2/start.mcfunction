# 設置已觸發，防止重複執行
scoreboard players set water2_triggered water_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
# 四道試煉門座標依序
# 角度正向東或西，俯視10度
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true
effect give @a blindness 1 0 true

execute positioned -1749 12 1520 facing -1749 12 1514 run function animated_java:character/summon {args: {variant: 'watergod'}}
execute positioned -1749 12 1520 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add watergod
summon text_display -1749 14 1520 {text:'{"text":"奈迪拉提雅","color":"white","bold":true}',billboard:"center",Tags:["water2_entity"]}

execute positioned -1747 12 1516 facing -1749 12 1520 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1747 12 1516 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon text_display -1747 14 1516 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["water2_entity"]}

tp @a -1749 12 1514 facing -1749 12 1520

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.water.water2.line1"},{t:60,type:"text",key:"story.water.water2.line2"},{t:120,type:"text",key:"story.water.water2.line3"},{t:180,type:"text",key:"story.water.water2.line4"},{t:240,type:"text",key:"story.water.water2.line5"},{t:300,type:"text",key:"story.water.water2.line6"},{t:360,type:"text",key:"story.water.water2.line7"},{t:420,type:"text",key:"story.water.water2.line8"},{t:480,type:"text",key:"story.water.water2.line9"},{t:540,type:"text",key:"story.water.water2.line10"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:60,type:"anim_trs",tag:"union",from:"breath",to:"sidehead"},{t:90,type:"anim_trs",tag:"union",from:"sidehead",to:"breath"},{t:120,type:"anim_trs",tag:"watergod",from:"breath",to:"give"},{t:120,type:"fn",fn:"dialogtest:water/water2/act2"},{t:150,type:"anim_trs",tag:"watergod",from:"give",to:"breath"},{t:240,type:"fn",fn:"dialogtest:water/water2/act3"},{t:480,type:"anim_trs",tag:"watergod",from:"breath",to:"nod"},{t:510,type:"anim_trs",tag:"watergod",from:"nod",to:"breath"}]
# act1 (t=60): 尤尼恩歪頭
# act2 (t=120): 奈迪拉提雅抬手看向尤尼恩
# act3 (t=240): 先依序開啟四道試煉場的門，再播放下一句
# act4 (t=480): 奈迪拉提雅點頭

# ctrl 軌：最後一行(line10, t=360)後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:600,type:"fn",fn:"dialogtest:water/water2/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "water_water2"
data modify storage dialogtest:story run.scene_tick set value 0
