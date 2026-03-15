# 設置已觸發，防止重複執行
scoreboard players set grass3_triggered grass_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -954 6 1922 facing -947 8 1919 run function animated_java:character/summon {args: {variant: 'woodgod'}}
execute positioned -954 6 1922 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add woodgod
summon text_display -954 8 1922 {text:'{"text":"木神","color":"green","bold":true}',billboard:"center",Tags:["grass3_entity"]}

execute positioned -936 6 1925 facing -954 6 1922 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -936 6 1925 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon text_display -936 8 1925 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["grass3_entity"]}

summon marker -947 8 1919 {Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -954 6 1922
tp @a -947 8 1919 facing -954 6 1922

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.grass.grass3.line1"},{t:85,type:"text",key:"story.grass.grass3.line2"},{t:145,type:"text",key:"story.grass.grass3.line3"},{t:205,type:"text_player",key:"story.grass.grass3.line4"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:25,type:"anim_trs",tag:"woodgod",from:"breath",to:"nod"},{t:55,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"},{t:85,type:"fn",fn:"dialogtest:grass/grass3/act2"},{t:145,type:"anim_trs",tag:"woodgod",from:"breath",to:"give"},{t:175,type:"anim_trs",tag:"woodgod",from:"give",to:"breath"},{t:205,type:"fn",fn:"dialogtest:grass/grass3/act4"}]
# act1 (t=0): 木神對花點頭後主角視角回到-932 6 1922看向木神
# act2 (t=60): 木神從-954 6 1922移動至-945 6 1922
# act3 (t=120): 木神抬手，讓水晶施放射線
# act4 (t=180): 開啟BOSS戰

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:245,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:265,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "grass_grass3"
data modify storage dialogtest:story run.scene_tick set value 0
