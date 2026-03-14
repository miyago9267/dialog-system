# 設置已觸發，防止重複執行
scoreboard players set fire1_triggered fire_story 1

# 鎖定玩家移動和視角
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true
effect give @a blindness 1 0 true

# 召喚 AJ 角色（尤尼恩）—— breath 由 union 軌在 t=0 觸發，不在此重複
execute positioned -2029 13 1764 facing -2032 13 1765 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -2029 13 1764 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union

# 召喚場景實體
summon text_display -2029 15 1764 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["fire1"]}
summon minecraft:villager -2029 13 1767 {NoAI:1b,Silent:1b,CustomName:'{"text":"鐵匠賽克","color":"gray"}',VillagerData:{profession:"minecraft:weaponsmith",level:2,type:"minecraft:plains"},Tags:["fire1","nod"]}
execute as @e[name="鐵匠賽克",tag=fire1] at @s run tp @s ~ ~ ~ facing -2032 13 1765

# 傳送玩家
tp @a -2032 13 1765 facing -2029 13 1767

# 重置村民移動狀態
scoreboard players set _fire1_villager_walking dialog_timer 0
data modify storage dialogtest:story run.villager_walk_phase set value 0

# ── 時間軸資料（每條軌道必須是單行指令，mcfunction 不支援反斜線續行）──

# text 軌：台詞序列，每行 60 ticks（3 秒），line1-2 為玩家台詞（帶角色名）
data modify storage dialogtest:story run.text set value [{t:0,type:"text_player",key:"story.fire.fire1.line1"},{t:60,type:"text_player",key:"story.fire.fire1.line2"},{t:120,type:"text",key:"story.fire.fire1.line3"},{t:180,type:"text",key:"story.fire.fire1.line4"},{t:240,type:"text",key:"story.fire.fire1.line5"},{t:300,type:"text",key:"story.fire.fire1.line6"},{t:360,type:"text",key:"story.fire.fire1.line7"},{t:420,type:"text",key:"story.fire.fire1.line8"},{t:480,type:"text",key:"story.fire.fire1.line9"},{t:540,type:"text",key:"story.fire.fire1.line10"},{t:600,type:"text",key:"story.fire.fire1.line11"},{t:660,type:"text",key:"story.fire.fire1.line12"},{t:720,type:"text",key:"story.fire.fire1.line13"},{t:780,type:"text",key:"story.fire.fire1.line14"},{t:840,type:"text",key:"story.fire.fire1.line15"}]

# union 軌：t=0 待機，t=360 點頭（與 line7 同步），t=391 恢復待機
data modify storage dialogtest:story run.union set value [{t:0,type:"anim_play",tag:"union",anim:"breath"},{t:360,type:"anim_trs",tag:"union",from:"breath",to:"nod"},{t:391,type:"anim_trs",tag:"union",from:"nod",to:"breath"}]

# villager 軌：t=540 開始走（line10 同步），t=660 換目標（line12 同步）
data modify storage dialogtest:story run.villager set value [{t:540,type:"fn",fn:"dialogtest:fire/fire1/villager_walk_to_dest1"},{t:660,type:"fn",fn:"dialogtest:fire/fire1/villager_walk_to_dest2"}]

# ctrl 軌：line15 顯示後 60 ticks 執行 cleanup
data modify storage dialogtest:story run.ctrl set value [{t:900,type:"fn",fn:"dialogtest:fire/fire1/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "fire1"
data modify storage dialogtest:story run.scene_tick set value 0
