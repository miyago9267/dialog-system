# 設置已觸發，防止重複執行
scoreboard players set grass3_triggered story_progress 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -954 6 1922 facing -960 5 1922 run function animated_java:character/summon {args: {variant: 'woodgod'}}
execute positioned -954 6 1922 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add woodgod
execute as @e[tag=woodgod] at @s run tp @s ~ ~ ~ facing -960 5 1922
summon text_display -954 8 1922 {text:'{"text":"木神","color":"green","bold":true}',billboard:"center",Tags:["grass3_entity"]}

execute positioned -936 6 1925 facing -954 6 1922 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -936 6 1925 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -954 6 1922
summon text_display -936 8 1925 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["grass3_entity"]}

summon marker -947 8 1919 {Rotation:[66.8f,14.7f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -954 6 1922
tp @a -947 8 1919 facing -954 6 1922

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（80t 間隔）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.grass.grass3.line1"},{t:105,type:"text",key:"story.grass.grass3.line2"},{t:185,type:"text",key:"story.grass.grass3.line3"},{t:265,type:"text_player",key:"story.grass.grass3.line4"}]

# action 軌
data modify storage dialogtest:story run.action set value [{t:25,type:"anim_trs",tag:"woodgod",from:"breath",to:"nod"},{t:45,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"},{t:55,type:"fn",fn:"dialogtest:grass/grass3/act1"},{t:105,type:"fn",fn:"dialogtest:grass/grass3/act2"},{t:185,type:"anim_trs",tag:"woodgod",from:"breath",to:"give"},{t:185,type:"fn",fn:"dialogtest:grass/grass3/act3"},{t:265,type:"fn",fn:"dialogtest:grass/grass3/act4"}]
# t=25: 木神對花點頭
# t=55: act1 - 鏡頭拉到 -932 6 1922 看向木神
# t=105: act2 - 木神移動至 -945 6 1922，轉向面對玩家方向
# t=185: act3 - 木神抬手，水晶射線粒子特效
# t=265: act4 - 開啟 BOSS 戰

# ctrl 軌：BOSS 戰轉場
data modify storage dialogtest:story run.ctrl set value [{t:305,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:345,type:"fn",fn:"dialogtest:grass/grass3/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "grass_grass3"
data modify storage dialogtest:story run.scene_tick set value 0
