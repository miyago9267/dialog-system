# fire3 場景清理（ctrl 軌觸發）

# 解除玩家鎖定
effect clear @a slowness
effect clear @a jump_boost

# 移除 AJ 角色
execute as @e[tag=firegod] run function animated_java:character/remove/this
execute as @e[tag=migale] run function animated_java:character/remove/this
execute as @e[tag=union] run function animated_java:character/remove/this

# 清除場景實體
kill @e[tag=fire3_entity]

# 結束時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode
