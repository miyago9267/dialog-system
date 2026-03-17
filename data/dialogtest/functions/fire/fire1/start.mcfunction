# 設置已觸發，防止重複執行
scoreboard players set fire1_triggered story_progress 1

# 切換觀察者模式（鎖位置由 timeline/tick 每 tick tp 處理）
gamemode spectator @a

# 召喚 AJ 角色（尤尼恩）at -2028 13 1764，面向賽克
execute positioned -2028 13 1764 facing -2029 13 1767 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -2028 13 1764 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -2029 13 1767

# 召喚場景實體
summon text_display -2028 15 1764 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["fire1"]}
summon minecraft:villager -2029 13 1767 {NoAI:1b,Silent:1b,CustomName:'{"text":"鐵匠賽克","color":"gray"}',VillagerData:{profession:"minecraft:weaponsmith",level:2,type:"minecraft:plains"},Tags:["fire1","nod"]}
execute as @e[name="鐵匠賽克",tag=fire1] at @s run tp @s ~ ~ ~ facing -2032 13 1763

# 放置相機 marker 並傳送玩家（主角 -2032 13 1763 看向賽克）
summon marker -2032 13 1763 {Rotation:[-36.9f,-0.0f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -2029 13 1767
tp @a -2032 13 1763 facing -2029 13 1767

# 重置村民移動狀態
scoreboard players set _fire1_villager_walking dialog_timer 0
data modify storage dialogtest:story run.villager_walk_phase set value 0

# ── 時間軸資料（每條軌道必須是單行指令，mcfunction 不支援反斜線續行）──

# text 軌：台詞序列，每行 60 ticks（3 秒），全部 +25 等黑幕結束
data modify storage dialogtest:story run.text set value [{t:25,type:"text_player",key:"story.fire.fire1.line1"},{t:105,type:"text_player",key:"story.fire.fire1.line2"},{t:185,type:"text",key:"story.fire.fire1.line3"},{t:265,type:"text",key:"story.fire.fire1.line4"},{t:345,type:"text",key:"story.fire.fire1.line5"},{t:425,type:"text",key:"story.fire.fire1.line6"},{t:505,type:"text",key:"story.fire.fire1.line7"},{t:585,type:"text",key:"story.fire.fire1.line8"},{t:665,type:"text",key:"story.fire.fire1.line9"},{t:745,type:"text",key:"story.fire.fire1.line10"},{t:825,type:"text",key:"story.fire.fire1.line11"},{t:905,type:"text",key:"story.fire.fire1.line12"},{t:985,type:"text",key:"story.fire.fire1.line13"},{t:1065,type:"text",key:"story.fire.fire1.line14"},{t:1145,type:"text",key:"story.fire.fire1.line15"}]

# union 軌：t=25 待機，t=385 點頭（line7，20tick=1圈），t=405 恢復待機
data modify storage dialogtest:story run.union set value [{t:25,type:"anim_play",tag:"union",anim:"breath"}]

# action 軌：t=205 特寫賽克（line4），t=265 回原位（line5）
data modify storage dialogtest:story run.action set value [{t:265,type:"fn",fn:"dialogtest:fire/fire1/closeup_seck"},{t:345,type:"fn",fn:"dialogtest:fire/fire1/closeup_reset"},{t:425,type:"fn",fn:"dialogtest:fire/fire1/union_face_player"},{t:505,type:"fn",fn:"dialogtest:fire/fire1/seck_nod_down"},{t:515,type:"fn",fn:"dialogtest:fire/fire1/seck_nod_up"}]

# villager 軌：+25，t=565 開始走（line10 同步），t=685 換目標（line12 同步）
data modify storage dialogtest:story run.villager set value [{t:715,type:"fn",fn:"dialogtest:fire/fire1/seck_face_player"},{t:745,type:"fn",fn:"dialogtest:fire/fire1/villager_walk_to_dest1"},{t:905,type:"fn",fn:"dialogtest:fire/fire1/villager_walk_to_dest2"}]

# ctrl 軌：t=905 結尾淡出（40t 後自動清除），t=925 cleanup
data modify storage dialogtest:story run.ctrl set value [{t:1185,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:1225,type:"fn",fn:"dialogtest:fire/fire1/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "fire1"
data modify storage dialogtest:story run.scene_tick set value 0
