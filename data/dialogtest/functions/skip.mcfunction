# 通用劇情跳過（測試用）
# 用法：/function dialogtest:skip
# 無論目前在播什麼劇情，直接跳過並清理

# 黑幕轉場（40 tick 後自動清除）
function dialogtest:operations/transition/fade_to_black

# 先輸出剩餘台詞
tellraw @a ["",{"text":"--------[","bold":true},{"text":"剩餘劇情文本","color":"#A7A7A7"},{"text":"]--------","bold":true}]
function dialogtest:operations/timeline/flush_text

# 停止時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode

# 解除玩家鎖定
gamemode adventure @a
kill @e[tag=scene_camera]
effect clear @a blindness

# 清除所有 AJ 角色
execute as @e[tag=aj.character.root] run function animated_java:character/remove/this

# 清除所有場景 text_display（角色名稱）
kill @e[type=text_display]

# 清除場景實體（火區特有）- 先傳走村民再殺，避免當面去世
tp @e[type=minecraft:villager,tag=fire1] ~ -64 ~
kill @e[tag=fire1]
kill @e[tag=fire2_entity]
kill @e[tag=fire2_pillar]
kill @e[tag=fire2_pillar2]
kill @e[tag=grass4_entity]

# 停止 fire1 村民移動
scoreboard players set _fire1_villager_walking dialog_timer 0

# 停止 grass4 罌粟跟蹤
scoreboard players set _grass4_poppy_tracking dialog_timer 0

tellraw @a {"text":"[劇情已跳過]","color":"yellow","italic":true}
