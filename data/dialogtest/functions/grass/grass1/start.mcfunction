# 設置已觸發，防止重複執行
scoreboard players set grass1_triggered story_progress 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -1392 6 1868 facing -1392 6 1900 run function animated_java:character/summon {args: {variant: 'woodgod'}}
execute positioned -1392 6 1868 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add woodgod
execute as @e[tag=woodgod] at @s run tp @s ~ ~ ~ facing -1392 6 1900
summon text_display -1392 8 1868 {text:'{"text":"木神","color":"green","bold":true}',billboard:"center",Tags:["grass1_entity"]}

execute positioned -1402 6 1867 facing -1392 6 1868 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1402 6 1867 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -1392 6 1868
summon text_display -1402 8 1867 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["grass1_entity"]}

summon marker -1405 6 1869 {Rotation:[-94.4f,-0.0f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1392 6 1868
tp @a -1405 6 1869 facing -1392 6 1868

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.grass.grass1.line1"},{t:105,type:"text",key:"story.grass.grass1.line2"},{t:185,type:"text",key:"story.grass.grass1.line3"},{t:265,type:"text_player",key:"story.grass.grass1.line4"},{t:345,type:"text",key:"story.grass.grass1.line5"},{t:425,type:"text_player",key:"story.grass.grass1.line6"},{t:505,type:"text",key:"story.grass.grass1.line7"},{t:585,type:"text",key:"story.grass.grass1.line8"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:185,type:"anim_trs",tag:"woodgod",from:"breath",to:"nod"},{t:205,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"},{t:345,type:"anim_trs",tag:"woodgod",from:"breath",to:"nod"},{t:345,type:"fn",fn:"dialogtest:grass/grass1/act2"},{t:365,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"},{t:505,type:"fn",fn:"dialogtest:grass/grass1/act3"}]
# act1 (t=120): 木神看著花點頭
# act2 (t=240): 木神快速看向主角點頭
# act3 (t=360): 化成苞子花粒子消失

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:625,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:665,type:"fn",fn:"dialogtest:grass/grass1/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "grass_grass1"
data modify storage dialogtest:story run.scene_tick set value 0
