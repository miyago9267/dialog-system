# 設置已觸發，防止重複執行
scoreboard players set water2_triggered story_progress 1

# ── 場景設置（站位） ──────────────────────────────────────────
# 奈迪拉提雅 -1749 12 1520 面向主角
# 尤尼恩 -1747 12 1516 面向奈迪拉提雅
# 主角 -1749 12 1514 面向奈迪拉提雅
gamemode spectator @a
execute positioned -1749 12 1520 facing -1749 12 1514 run function animated_java:character/summon {args: {variant: 'watergod'}}
execute positioned -1749 12 1520 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add watergod
execute as @e[tag=watergod] at @s run tp @s ~ ~ ~ facing -1749 12 1514
summon text_display -1749 14 1520 {text:'{"text":"奈迪拉提雅","color":"aqua","bold":true}',billboard:"center",Tags:["water2_entity"]}

execute positioned -1747 12 1516 facing -1749 12 1520 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1747 12 1516 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -1749 12 1520
summon text_display -1747 14 1516 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["water2_entity"]}

summon marker -1749 12 1514 {Rotation:[0.0f,0.0f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1749 12 1520
tp @a -1749 12 1514 facing -1749 12 1520

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（line5 後插入開門序列，line6 延至 t=605）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.water.water2.line1"},{t:105,type:"text",key:"story.water.water2.line2"},{t:185,type:"text",key:"story.water.water2.line3"},{t:265,type:"text",key:"story.water.water2.line4"},{t:345,type:"text",key:"story.water.water2.line5"},{t:605,type:"text",key:"story.water.water2.line6"},{t:685,type:"text",key:"story.water.water2.line7"},{t:765,type:"text",key:"story.water.water2.line8"},{t:845,type:"text",key:"story.water.water2.line9"},{t:925,type:"text",key:"story.water.water2.line10"}]

# action 軌
# t=105: 尤尼恩歪頭 (sidehead 100t)
# t=185: 奈迪拉提雅抬手看向尤尼恩 (give 110t)
# t=365~555: 鏡頭先到位(cam)，10t後開門(door)
# t=595: 鏡頭回到角色
# t=845: 奈迪拉提雅點頭 (nod 20t)
data modify storage dialogtest:story run.action set value [{t:105,type:"anim_trs",tag:"union",from:"breath",to:"sidehead"},{t:185,type:"anim_trs",tag:"watergod",from:"breath",to:"give"},{t:185,type:"fn",fn:"dialogtest:water/water2/act2"},{t:205,type:"anim_trs",tag:"union",from:"sidehead",to:"breath"},{t:295,type:"anim_trs",tag:"watergod",from:"give",to:"breath"},{t:365,type:"fn",fn:"dialogtest:water/water2/act3_cam1"},{t:375,type:"fn",fn:"dialogtest:water/water2/act3_door1"},{t:425,type:"fn",fn:"dialogtest:water/water2/act3_cam2"},{t:435,type:"fn",fn:"dialogtest:water/water2/act3_door2"},{t:485,type:"fn",fn:"dialogtest:water/water2/act3_cam3"},{t:495,type:"fn",fn:"dialogtest:water/water2/act3_door3"},{t:545,type:"fn",fn:"dialogtest:water/water2/act3_cam4"},{t:555,type:"fn",fn:"dialogtest:water/water2/act3_door4"},{t:595,type:"fn",fn:"dialogtest:water/water2/act3_return"},{t:845,type:"anim_trs",tag:"watergod",from:"breath",to:"nod"},{t:865,type:"anim_trs",tag:"watergod",from:"nod",to:"breath"}]

# ctrl 軌
data modify storage dialogtest:story run.ctrl set value [{t:965,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:1005,type:"fn",fn:"dialogtest:water/water2/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "water_water2"
data modify storage dialogtest:story run.scene_tick set value 0
