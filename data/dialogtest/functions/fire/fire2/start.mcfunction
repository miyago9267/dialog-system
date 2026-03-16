# 設置已觸發，防止重複執行
scoreboard players set fire2_triggered fire_story 1

# 切換觀察者模式（鎖位置由 timeline/tick 每 tick tp 處理）
gamemode spectator @a
# 放置相機 marker 並傳送玩家（面向 boss 出現位置）
summon marker -2400 18 1724 {Rotation:[-78.7f,0.0f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -2385 18 1727
tp @a -2400 18 1724 facing -2385 18 1727

# 召喚 AJ 角色（尤尼恩）
execute positioned -2397 18 1729 rotated 40 0 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -2397 18 1729 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ 40 0
summon text_display -2397 20 1729 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["fire2_entity"]}
tp @e[tag=union] -2397 18 1729 -110 0

# 給尤尼恩戴上玩家頭顱
data modify entity @e[name="尤尼恩",limit=1] ArmorItems insert 3 value {id:"minecraft:player_head",Count:1b,tag:{SkullOwner:"oXMilciaXo"}}

# ── 時間軸資料 ──────────────────────────────────────────────

# text 軌：對話序列（line3~7），BOSS 出現後開始
data modify storage dialogtest:story run.text set value [{t:475,type:"text",key:"story.fire.fire2.line3"},{t:595,type:"text",key:"story.fire.fire2.line4"},{t:695,type:"text_player",key:"story.fire.fire2.line5"},{t:795,type:"text",key:"story.fire.fire2.line6"},{t:915,type:"text",key:"story.fire.fire2.line7"}]

# ctrl 軌：t=290 召喚火靈神，t=730 清理場景
data modify storage dialogtest:story run.ctrl set value [{t:395,type:"fn",fn:"dialogtest:fire/fire2/summon_firegod"},{t:955,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:995,type:"fn",fn:"dialogtest:fire/fire2/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "fire_fire2"
data modify storage dialogtest:story run.scene_tick set value 0
