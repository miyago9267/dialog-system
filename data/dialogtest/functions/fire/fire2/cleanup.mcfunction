# fire2 場景清理（ctrl 軌 t=730 觸發）

# 失明過場效果
effect give @a minecraft:blindness 2 3 true

# 解除玩家鎖定
gamemode adventure @a
kill @e[tag=scene_camera]

# 移除 AJ 角色
execute as @e[tag=union] run function animated_java:character/remove/this
execute as @e[tag=firegod] run function animated_java:character/remove/this

# 清除場景實體（名牌等）
kill @e[name="尤尼恩"]
kill @e[name="阿多賽忒喀"]
kill @e[tag=fire2_entity]

# 安全清理火柱（正常情況下已在 summon_firegod 中清除）
kill @e[tag=fire2_pillar]
kill @e[tag=fire2_pillar2]

# 結束時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode
