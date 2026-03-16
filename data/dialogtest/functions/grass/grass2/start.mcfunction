# 設置已觸發，防止重複執行
scoreboard players set grass2_triggered grass_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -1215 5 1794 facing -1214 6 1784 run function animated_java:character/summon {args: {variant: 'woodgod'}}
execute positioned -1215 5 1794 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add woodgod
execute as @e[tag=woodgod] at @s run tp @s ~ ~ ~ facing -1214 6 1784
summon text_display -1215 7 1794 {text:'{"text":"木神","color":"green","bold":true}',billboard:"center",Tags:["grass2_entity"]}

execute positioned -1212 6 1787 facing -1215 5 1794 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1212 6 1787 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -1215 5 1794
summon text_display -1212 8 1787 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["grass2_entity"]}

summon marker -1214 6 1784 {Rotation:[5.7f,5.7f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1215 5 1794
tp @a -1214 6 1784 facing -1215 5 1794

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.grass.grass2.line1"},{t:105,type:"text",key:"story.grass.grass2.line2"},{t:185,type:"text",key:"story.grass.grass2.line3"},{t:265,type:"text",key:"story.grass.grass2.line4"},{t:345,type:"text",key:"story.grass.grass2.line5"},{t:425,type:"text",key:"story.grass.grass2.line6"},{t:505,type:"text",key:"story.grass.grass2.line7"},{t:585,type:"text_player",key:"story.grass.grass2.line8"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:265,type:"fn",fn:"dialogtest:grass/grass2/act1"},{t:425,type:"fn",fn:"dialogtest:grass/grass2/act2"}]
# act1 (t=180): 木神看向玩家
# act2 (t=300): 化成苞子花粒子消失

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:625,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:665,type:"fn",fn:"dialogtest:grass/grass2/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "grass_grass2"
data modify storage dialogtest:story run.scene_tick set value 0
