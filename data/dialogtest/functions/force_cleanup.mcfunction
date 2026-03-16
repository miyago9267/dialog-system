# 強制清除所有劇情元素（debug 用）
# 用於中途 reload 或異常狀態後的緊急清理

# 停止時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode
data remove storage dialogtest:story run.text
data remove storage dialogtest:story run.action
data remove storage dialogtest:story run.ctrl
data remove storage dialogtest:story run.union
data remove storage dialogtest:story run.villager
scoreboard players set _scene_tick dialog_timer 0
scoreboard players set _fire1_villager_walking dialog_timer 0

# 解除玩家鎖定
gamemode adventure @a
effect clear @a darkness
effect clear @a blindness
kill @e[tag=scene_camera]

# 清除所有 AJ 角色
execute as @e[tag=aj.character.root] run function animated_java:character/remove/this

# 清除所有 text_display（角色名稱）
kill @e[type=text_display]

# 清除所有場景專屬實體
tp @e[type=minecraft:villager,tag=fire1] ~ -64 ~
kill @e[tag=fire1]
kill @e[tag=fire2_entity]
kill @e[tag=fire2_pillar]
kill @e[tag=fire2_pillar2]
kill @e[tag=fire3_entity]
kill @e[tag=grass1_entity]
kill @e[tag=grass2_entity]
kill @e[tag=grass3_entity]
kill @e[tag=grass4_entity]
kill @e[tag=water1_entity]
kill @e[tag=water2_entity]
kill @e[tag=water3_entity]
kill @e[tag=water4_entity]
kill @e[tag=light1_entity]
kill @e[tag=light2_entity]
kill @e[tag=light3_entity]

# 重置跳過
scoreboard players set @a skip_scene 0

tellraw @a {"text":"[強制清除完成]","color":"red","bold":true}
