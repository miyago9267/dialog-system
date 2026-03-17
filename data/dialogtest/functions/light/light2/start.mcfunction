# 設置已觸發，防止重複執行
scoreboard players set light2_triggered light_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -1822 32 2154 facing -1835 32 2154 run function animated_java:character/summon {args: {variant: 'lightgod'}}
execute positioned -1822 32 2154 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add lightgod
execute as @e[tag=lightgod] at @s run tp @s ~ ~ ~ facing -1835 32 2154
summon text_display -1822 34 2154 {text:'{"text":"光神","color":"yellow","bold":true}',billboard:"center",Tags:["light2_entity"]}

execute positioned -1828 32 2148 facing -1822 32 2154 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1828 32 2148 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -1822 32 2154
summon text_display -1828 34 2148 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["light2_entity"]}

# 開場特寫：鏡頭從光神近景開始
summon marker -1826 32 2154 {Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1822 32 2154
tp @a -1826 32 2154 facing -1822 32 2154

# 淡入（從黑畫面進場）
schedule function dialogtest:operations/transition/fade_from_black 1t

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（5 行，80t 間隔）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.light.light2.line1"},{t:105,type:"text",key:"story.light.light2.line2"},{t:185,type:"text",key:"story.light.light2.line3"},{t:265,type:"text",key:"story.light.light2.line4"},{t:345,type:"text",key:"story.light.light2.line5"}]

# action 軌
data modify storage dialogtest:story run.action set value [{t:55,type:"fn",fn:"dialogtest:light/light2/act1"},{t:185,type:"anim_trs",tag:"lightgod",from:"breath",to:"nod"},{t:205,type:"anim_trs",tag:"lightgod",from:"nod",to:"breath"},{t:345,type:"anim_trs",tag:"lightgod",from:"breath",to:"wavehand"},{t:380,type:"anim_trs",tag:"lightgod",from:"wavehand",to:"breath"}]
# t=55: act1 - 鏡頭從特寫後退至玩家視角
# t=185: 光神點頭（inline anim_trs）
# t=345: 光神揮手（inline anim_trs）

# ctrl 軌
data modify storage dialogtest:story run.ctrl set value [{t:385,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:425,type:"fn",fn:"dialogtest:light/light2/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "light_light2"
data modify storage dialogtest:story run.scene_tick set value 0
