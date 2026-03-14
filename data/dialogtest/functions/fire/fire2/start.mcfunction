# 設置已觸發，防止重複執行
scoreboard players set fire2_triggered fire_story 1

# 鎖定玩家移動和視角
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true
effect give @a blindness 1 0 true

# 傳送玩家到觀看位置（面向場地中央）
tp @a -2400 18 1724 -70 0

# 召喚 AJ 角色（尤尼恩）
execute positioned -2397 18 1729 rotated 40 0 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -2397 18 1729 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon text_display -2397 20 1729 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["fire2_entity"]}
tp @e[tag=union] -2397 18 1729 -110 0

# 給尤尼恩戴上玩家頭顱
data modify entity @e[name="尤尼恩",limit=1] ArmorItems insert 3 value {id:"minecraft:player_head",Count:1b,tag:{SkullOwner:"oXMilciaXo"}}

# ── 時間軸資料 ──────────────────────────────────────────────

# text 軌：對話序列（line3~7），BOSS 出現後開始
data modify storage dialogtest:story run.text set value [{t:350,type:"text",key:"story.fire.fire2.line3"},{t:430,type:"text",key:"story.fire.fire2.line4"},{t:510,type:"text_player",key:"story.fire.fire2.line5"},{t:590,type:"text",key:"story.fire.fire2.line6"},{t:670,type:"text",key:"story.fire.fire2.line7"}]

# ctrl 軌：t=290 召喚火靈神，t=730 清理場景
data modify storage dialogtest:story run.ctrl set value [{t:290,type:"fn",fn:"dialogtest:fire/fire2/summon_firegod"},{t:730,type:"fn",fn:"dialogtest:fire/fire2/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "fire_fire2"
data modify storage dialogtest:story run.scene_tick set value 0
