# 設置已觸發，防止重複執行
scoreboard players set water1_triggered water_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -1749 74 1498 facing -1749 74 1504 run function animated_java:character/summon {args: {variant: 'watergod'}}
execute positioned -1749 74 1498 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add watergod
summon text_display -1749 76 1498 {text:'{"text":"奈迪拉提雅","color":"aqua","bold":true}',billboard:"center",Tags:["water1_entity"]}

execute positioned -1751 74 1502 facing -1749 74 1498 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1751 74 1502 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon text_display -1751 76 1502 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["water1_entity"]}

summon marker -1749 74 1504 {Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1749 74 1498
tp @a -1749 74 1504 facing -1749 74 1498

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.water.water1.line1"},{t:125,type:"text",key:"story.water.water1.line2"},{t:225,type:"text",key:"story.water.water1.line3"},{t:325,type:"text",key:"story.water.water1.line4"},{t:425,type:"text",key:"story.water.water1.line5"},{t:525,type:"text",key:"story.water.water1.line6"},{t:625,type:"text",key:"story.water.water1.line7"},{t:725,type:"text",key:"story.water.water1.line8"},{t:825,type:"text",key:"story.water.water1.line9"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:25,type:"anim_trs",tag:"watergod",from:"breath",to:"give"},{t:25,type:"fn",fn:"dialogtest:water/water1/act1"},{t:55,type:"anim_trs",tag:"watergod",from:"give",to:"breath"},{t:225,type:"anim_trs",tag:"watergod",from:"breath",to:"bow"},{t:325,type:"anim_trs",tag:"watergod",from:"bow",to:"breath"}]
# act1 (t=0): 奈迪拉提雅抬手看向主角
# act2 (t=120): 奈迪拉提雅向主角鞠躬

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:865,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:925,type:"fn",fn:"dialogtest:water/water1/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "water_water1"
data modify storage dialogtest:story run.scene_tick set value 0
