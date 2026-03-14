# 設置已觸發，防止重複執行
scoreboard players set grass1_triggered grass_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true
effect give @a blindness 1 0 true

execute positioned -1392 6 1868 facing -1405 6 1869 run function animated_java:character/summon {args: {variant: 'woodgod'}}
execute positioned -1392 6 1868 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add woodgod
summon text_display -1392 8 1868 {text:'{"text":"木神","color":"white","bold":true}',billboard:"center",Tags:["grass1_entity"]}

execute positioned -1402 6 1867 facing -1392 6 1868 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1402 6 1867 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon text_display -1402 8 1867 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["grass1_entity"]}

tp @a -1405 6 1869 facing -1392 6 1868

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.grass.grass1.line1"},{t:60,type:"text",key:"story.grass.grass1.line2"},{t:120,type:"text",key:"story.grass.grass1.line3"},{t:180,type:"text_player",key:"story.grass.grass1.line4"},{t:240,type:"text",key:"story.grass.grass1.line5"},{t:300,type:"text_player",key:"story.grass.grass1.line6"},{t:360,type:"text",key:"story.grass.grass1.line7"},{t:420,type:"text",key:"story.grass.grass1.line8"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:120,type:"anim_trs",tag:"woodgod",from:"breath",to:"nod"},{t:150,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"},{t:240,type:"anim_trs",tag:"woodgod",from:"breath",to:"nod"},{t:240,type:"fn",fn:"dialogtest:grass/grass1/act2"},{t:270,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"},{t:360,type:"fn",fn:"dialogtest:grass/grass1/act3"}]
# act1 (t=120): 木神看著花點頭
# act2 (t=240): 木神快速看向主角點頭
# act3 (t=360): 化成苞子花粒子消失

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:480,type:"fn",fn:"dialogtest:grass/grass1/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "grass_grass1"
data modify storage dialogtest:story run.scene_tick set value 0
