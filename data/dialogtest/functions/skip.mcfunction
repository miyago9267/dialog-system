# 通用劇情跳過（測試用）
# 用法：/function dialogtest:skip
# 無論目前在播什麼劇情，直接跳過並清理

# 先輸出剩餘台詞
tellraw @a ["",{"text":"--------[","bold":true},{"text":"剩餘劇情文本","color":"#A7A7A7"},{"text":"]--------","bold":true}]
function dialogtest:operations/timeline/flush_text

# 停止時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode

# 清除玩家效果
effect clear @a slowness
effect clear @a jump_boost
effect clear @a blindness

# 清除所有 AJ 角色
execute as @e[tag=aj.character.root] run function animated_java:character/remove/this

# 清除場景實體
kill @e[tag=fire1]
kill @e[tag=fire2_entity]
kill @e[tag=fire2_pillar]
kill @e[tag=fire2_pillar2]
kill @e[name="尤尼恩"]
kill @e[name="阿多賽忒喀"]
kill @e[name="鐵匠賽克"]

# 停止 fire1 村民移動
scoreboard players set _fire1_villager_walking dialog_timer 0

tellraw @a {"text":"[劇情已跳過]","color":"yellow","italic":true}
