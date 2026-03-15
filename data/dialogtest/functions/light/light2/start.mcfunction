# 設置已觸發，防止重複執行
scoreboard players set light2_triggered light_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a
execute positioned -1822 32 2154 facing -1835 32 2154 run function animated_java:character/summon {args: {variant: 'lightgod'}}
execute positioned -1822 32 2154 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add lightgod
summon text_display -1822 34 2154 {text:'{"text":"光神","color":"yellow","bold":true}',billboard:"center",Tags:["light2_entity"]}

execute positioned -1828 32 2148 facing -1822 32 2154 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1828 32 2148 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon text_display -1828 34 2148 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["light2_entity"]}

summon marker -1835 32 2154 {Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1822 32 2154
tp @a -1835 32 2154 facing -1822 32 2154

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.light.light2.line1"},{t:125,type:"text",key:"story.light.light2.line2"},{t:225,type:"text",key:"story.light.light2.line3"},{t:325,type:"text",key:"story.light.light2.line4"},{t:425,type:"text",key:"story.light.light2.line5"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:25,type:"fn",fn:"dialogtest:light/light2/act1"},{t:225,type:"anim_trs",tag:"lightgod",from:"breath",to:"nod"},{t:245,type:"anim_trs",tag:"lightgod",from:"nod",to:"breath"},{t:425,type:"anim_trs",tag:"lightgod",from:"breath",to:"wavehand"},{t:455,type:"anim_trs",tag:"lightgod",from:"wavehand",to:"breath"}]
# act1 (t=0): 黑畫面後特寫光神再後退至玩家視角
# act2 (t=120): 光神點頭
# act3 (t=240): 光神向主角揮手

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:465,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:525,type:"fn",fn:"dialogtest:light/light2/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "light_light2"
data modify storage dialogtest:story run.scene_tick set value 0
