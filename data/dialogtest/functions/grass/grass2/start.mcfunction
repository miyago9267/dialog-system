# 設置已觸發，防止重複執行
scoreboard players set grass2_triggered grass_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true
effect give @a blindness 1 0 true

execute positioned -1215 5 1794 facing -1214 6 1784 run function animated_java:character/summon {args: {variant: 'woodgod'}}
execute positioned -1215 5 1794 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add woodgod
summon text_display -1215 7 1794 {text:'{"text":"木神","color":"white","bold":true}',billboard:"center",Tags:["grass2_entity"]}

execute positioned -1212 6 1787 facing -1215 5 1794 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1212 6 1787 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon text_display -1212 8 1787 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["grass2_entity"]}

tp @a -1214 6 1784 facing -1215 5 1794

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.grass.grass2.line1"},{t:60,type:"text",key:"story.grass.grass2.line2"},{t:120,type:"text",key:"story.grass.grass2.line3"},{t:180,type:"text",key:"story.grass.grass2.line4"},{t:240,type:"text",key:"story.grass.grass2.line5"},{t:300,type:"text",key:"story.grass.grass2.line6"},{t:360,type:"text",key:"story.grass.grass2.line7"},{t:420,type:"text_player",key:"story.grass.grass2.line8"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:180,type:"fn",fn:"dialogtest:grass/grass2/act1"},{t:300,type:"fn",fn:"dialogtest:grass/grass2/act2"}]
# act1 (t=180): 木神看向玩家
# act2 (t=300): 化成苞子花粒子消失

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:480,type:"fn",fn:"dialogtest:grass/grass2/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "grass_grass2"
data modify storage dialogtest:story run.scene_tick set value 0
