# 設置已觸發，防止重複執行
scoreboard players set light1_triggered light_story 1

# ── 場景設置（站位） ──────────────────────────────────────────
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true
effect give @a blindness 1 0 true

execute positioned -1765 82 2112 facing -1772 82 2112 run function animated_java:character/summon {args: {variant: 'lightgod'}}
execute positioned -1765 82 2112 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add lightgod
summon text_display -1765 84 2112 {text:'{"text":"光神","color":"white","bold":true}',billboard:"center",Tags:["light1_entity"]}

execute positioned -1771 82 2111 facing -1765 82 2112 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -1771 82 2111 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon text_display -1771 84 2111 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["light1_entity"]}

tp @a -1772 82 2112 facing -1765 82 2112

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 60 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.light.light1.line1"},{t:60,type:"text",key:"story.light.light1.line2"},{t:120,type:"text",key:"story.light.light1.line3"},{t:180,type:"text",key:"story.light.light1.line4"},{t:240,type:"text",key:"story.light.light1.line5"},{t:300,type:"text",key:"story.light.light1.line6"},{t:360,type:"text",key:"story.light.light1.line7"},{t:420,type:"text_player",key:"story.light.light1.line8"},{t:480,type:"text",key:"story.light.light1.line9"},{t:540,type:"text",key:"story.light.light1.line10"},{t:600,type:"text",key:"story.light.light1.line11"},{t:660,type:"text",key:"story.light.light1.line12"}]

# action 軌（AJ 動畫與攝影機動作）
data modify storage dialogtest:story run.action set value [{t:0,type:"anim_trs",tag:"lightgod",from:"breath",to:"wavehand"},{t:30,type:"anim_trs",tag:"lightgod",from:"wavehand",to:"breath"},{t:120,type:"anim_trs",tag:"union",from:"breath",to:"give"},{t:150,type:"anim_trs",tag:"union",from:"give",to:"breath"},{t:180,type:"anim_trs",tag:"lightgod",from:"breath",to:"shakehead"},{t:210,type:"anim_trs",tag:"lightgod",from:"shakehead",to:"breath"},{t:240,type:"fn",fn:"dialogtest:light/light1/act4"},{t:300,type:"fn",fn:"dialogtest:light/light1/act5"},{t:360,type:"fn",fn:"dialogtest:light/light1/act6"},{t:420,type:"fn",fn:"dialogtest:light/light1/act7"},{t:540,type:"anim_trs",tag:"lightgod",from:"breath",to:"give"},{t:570,type:"anim_trs",tag:"lightgod",from:"give",to:"breath"},{t:600,type:"fn",fn:"dialogtest:light/light1/act9"}]
# act1 (t=0): 光神向主角揮手
# act2 (t=120): 尤尼恩抬手
# act3 (t=180): 光神搖頭
# act4 (t=240): 特寫光神
# act5 (t=300): 主角視角移動看向-1775 82 2112
# act6 (t=360): 主角視角轉移至-1775 166 2154 90 -5
# act7 (t=420): 回到初始點看向光神
# act8 (t=540): 光神抬手
# act9 (t=600): 光神往後跑走

# ctrl 軌：最後一行後 60 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:720,type:"fn",fn:"dialogtest:light/light1/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "light_light1"
data modify storage dialogtest:story run.scene_tick set value 0
