# 設置已觸發，防止重複執行
scoreboard players set light4_triggered light_story 1

# ── 場景設置（站位：同 light3 戰場） ──────────────────────────
gamemode spectator @a
execute positioned -1687 28 2154 facing -1699 28 2154 run function animated_java:character/summon {args: {variant: 'lightgod'}}
execute positioned -1687 28 2154 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add lightgod
execute as @e[tag=lightgod] at @s run tp @s ~ ~ ~ facing -1699 28 2154
summon text_display -1687 30 2154 {text:'{"text":"光神","color":"yellow","bold":true}',billboard:"center",Tags:["light4_entity"]}

execute positioned -1698 28 2153 facing -1687 28 2154 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1698 28 2153 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -1687 28 2154
summon text_display -1698 30 2153 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["light4_entity"]}

summon marker -1699 28 2154 {Rotation:[-90.0f,0.0f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1687 28 2154
tp @a -1699 28 2154 facing -1687 28 2154

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（8 行，80t 間隔）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.light.light4.line1"},{t:105,type:"text",key:"story.light.light4.line2"},{t:185,type:"text",key:"story.light.light4.line3"},{t:265,type:"text",key:"story.light.light4.line4"},{t:345,type:"text",key:"story.light.light4.line5"},{t:425,type:"text",key:"story.light.light4.line6"},{t:505,type:"text",key:"story.light.light4.line7"},{t:585,type:"text",key:"story.light.light4.line8"}]

# action 軌
data modify storage dialogtest:story run.action set value [{t:105,type:"anim_trs",tag:"lightgod",from:"breath",to:"nod"},{t:125,type:"anim_trs",tag:"lightgod",from:"nod",to:"breath"},{t:345,type:"fn",fn:"dialogtest:light/light4/act1"},{t:425,type:"fn",fn:"dialogtest:light/light4/act2"}]
# t=105: 光神點頭（inline nod）
# t=345: act1 - 特寫光神
# t=425: act2 - 退回至主角視角

# ctrl 軌
data modify storage dialogtest:story run.ctrl set value [{t:625,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:665,type:"fn",fn:"dialogtest:light/light4/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "light_light4"
data modify storage dialogtest:story run.scene_tick set value 0
