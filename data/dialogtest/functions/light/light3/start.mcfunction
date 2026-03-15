# 設置已觸發，防止重複執行
scoreboard players set light3_triggered light_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -1687 28 2154 facing -1699 28 2154 run function animated_java:character/summon {args: {variant: 'lightgod'}}
execute positioned -1687 28 2154 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add lightgod
summon text_display -1687 30 2154 {text:'{"text":"光神","color":"yellow","bold":true}',billboard:"center",Tags:["light3_entity"]}

execute positioned -1698 28 2153 facing -1687 28 2154 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1698 28 2153 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon text_display -1698 30 2153 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["light3_entity"]}

summon marker -1699 28 2154 {Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1687 28 2154
tp @a -1699 28 2154 facing -1687 28 2154

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.light.light3.line1"},{t:85,type:"text",key:"story.light.light3.line2"},{t:145,type:"text_player",key:"story.light.light3.line3"},{t:205,type:"text",key:"story.light.light3.line4"},{t:265,type:"text",key:"story.light.light3.line5"},{t:325,type:"text",key:"story.light.light3.line6"},{t:385,type:"text",key:"story.light.light3.line7"},{t:445,type:"text",key:"story.light.light3.line8"},{t:505,type:"text",key:"story.light.light3.line9"},{t:565,type:"text",key:"story.light.light3.line10"},{t:625,type:"text",key:"story.light.light3.line11"},{t:685,type:"text",key:"story.light.light3.line12"},{t:745,type:"text",key:"story.light.light3.line13"},{t:805,type:"text",key:"story.light.light3.line14"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:25,type:"anim_trs",tag:"lightgod",from:"breath",to:"nod"},{t:55,type:"anim_trs",tag:"lightgod",from:"nod",to:"breath"},{t:145,type:"anim_trs",tag:"lightgod",from:"breath",to:"give"},{t:175,type:"anim_trs",tag:"lightgod",from:"give",to:"breath"},{t:325,type:"anim_trs",tag:"lightgod",from:"breath",to:"kick"},{t:355,type:"anim_trs",tag:"lightgod",from:"kick",to:"breath"},{t:445,type:"anim_trs",tag:"lightgod",from:"breath",to:"nod"},{t:475,type:"anim_trs",tag:"lightgod",from:"nod",to:"breath"},{t:625,type:"fn",fn:"dialogtest:light/light3/act5"},{t:685,type:"fn",fn:"dialogtest:light/light3/act6"}]
# act1 (t=0): 光神點頭
# act2 (t=120): 光神抬手
# act3 (t=300): 光神撥開，開啟BOSS戰
# act4 (t=420): 光神點頭
# act5 (t=600): 特寫光神
# act6 (t=660): 退回至主角視角

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:845,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:865,type:"fn",fn:"dialogtest:light/light3/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "light_light3"
data modify storage dialogtest:story run.scene_tick set value 0
