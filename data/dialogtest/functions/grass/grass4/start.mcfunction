# 設置已觸發，防止重複執行
scoreboard players set grass4_triggered grass_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -945 6 1922 facing -932 6 1922 run function animated_java:character/summon {args: {variant: 'woodgod'}}
execute positioned -945 6 1922 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add woodgod
execute as @e[tag=woodgod] at @s run tp @s ~ ~ ~ facing -932 6 1922
summon text_display -945 8 1922 {text:'{"text":"木神","color":"green","bold":true}',billboard:"center",Tags:["grass4_entity"]}

execute positioned -936 6 1925 facing -945 6 1922 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -936 6 1925 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -945 6 1922
summon text_display -936 8 1925 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["grass4_entity"]}

summon marker -932 6 1922 {Rotation:[90.0f,-0.0f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -945 6 1922
tp @a -932 6 1922 facing -945 6 1922

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.grass.grass4.line1"},{t:105,type:"text",key:"story.grass.grass4.line2"},{t:185,type:"text",key:"story.grass.grass4.line3"},{t:265,type:"text",key:"story.grass.grass4.line4"},{t:345,type:"text",key:"story.grass.grass4.line5"},{t:425,type:"text",key:"story.grass.grass4.line6"},{t:505,type:"text",key:"story.grass.grass4.line7"},{t:585,type:"text",key:"story.grass.grass4.line8"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:25,type:"anim_trs",tag:"woodgod",from:"breath",to:"nod"},{t:45,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"},{t:105,type:"anim_trs",tag:"woodgod",from:"breath",to:"nod"},{t:125,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"},{t:185,type:"anim_trs",tag:"woodgod",from:"breath",to:"give"},{t:185,type:"fn",fn:"dialogtest:grass/grass4/act3"},{t:295,type:"anim_trs",tag:"woodgod",from:"give",to:"breath"},{t:425,type:"fn",fn:"dialogtest:grass/grass4/act4"}]
# act1 (t=0): 木神點頭
# act2 (t=60): 木神點頭
# act3 (t=120): 木神從-945 6 1922移動至-937 6 1925，面向尤尼恩抬手拿花，隨後花轉移至尤尼恩手上，木神再移動至-934 6 1922看向主角，尤尼恩隨著移動慢慢轉向木神，木神抬手拿花接著說下一句
# act4 (t=300): 化成苞子花粒子消失

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:625,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:665,type:"fn",fn:"dialogtest:grass/grass4/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "grass_grass4"
data modify storage dialogtest:story run.scene_tick set value 0
