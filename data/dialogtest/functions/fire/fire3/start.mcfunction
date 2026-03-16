# 設置已觸發，防止重複執行
scoreboard players set fire3_triggered fire_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -2386 18 1727 facing -2396 18 1727 run function animated_java:character/summon {args: {variant: 'firegod'}}
execute positioned -2386 18 1727 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add firegod
execute as @e[tag=firegod] at @s run tp @s ~ ~ ~ facing -2396 18 1727
summon text_display -2386 20 1727 {text:'{"text":"阿多賽忒喀","color":"red","bold":true}',billboard:"center",Tags:["fire3_entity"]}

execute positioned -2393 18 1730 facing -2386 18 1727 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -2393 18 1730 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -2386 18 1727
summon text_display -2393 20 1730 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["fire3_entity"]}

execute positioned -2397 18 1724 facing -2391 18 1724 run function animated_java:character/summon {args: {variant: 'migale'}}
execute positioned -2397 18 1724 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add migale
execute as @e[tag=migale] at @s run tp @s ~ ~ ~ facing -2391 18 1724
summon text_display -2397 20 1724 {text:'{"text":"米迦爾","color":"white","bold":true}',billboard:"center",Tags:["fire3_entity"]}

summon marker -2396 18 1727 {Rotation:[-90.0f,-0.0f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -2386 18 1727
tp @a -2396 18 1727 facing -2386 18 1727

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.fire.fire3.line1"},{t:65,type:"text",key:"story.fire.fire3.line2"},{t:125,type:"text",key:"story.fire.fire3.line3"},{t:185,type:"text",key:"story.fire.fire3.line4"},{t:225,type:"text",key:"story.fire.fire3.line5"},{t:285,type:"text",key:"story.fire.fire3.line6"},{t:345,type:"text",key:"story.fire.fire3.line7"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:125,type:"fn",fn:"dialogtest:fire/fire3/act1"},{t:185,type:"anim_trs",tag:"migale",from:"breath",to:"kick"},{t:195,type:"anim_trs",tag:"migale",from:"kick",to:"breath"},{t:225,type:"fn",fn:"dialogtest:fire/fire3/act3"}]
# act1 (t=80): 米迦爾邊說邊從後方走來並看向火神再說下一句
# act2 (t=120): 米迦爾撥開
# act3 (t=160): 火神播放火焰粒子後消失

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:365,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:385,type:"fn",fn:"dialogtest:fire/fire3/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "fire_fire3"
data modify storage dialogtest:story run.scene_tick set value 0
