# water2 場景清理（ctrl 軌觸發）

# 延後黑幕清除（讓玩家落地再亮起）
schedule function dialogtest:operations/transition/fade_from_black 60t

# 解除玩家鎖定，緩降落地
effect give @a slow_falling 5 0 true
tp @a -1749 12 1514
gamemode adventure @a
kill @e[tag=scene_camera]

# 移除 AJ 角色
execute as @e[tag=union] run function animated_java:character/remove/this
execute as @e[tag=watergod] run function animated_java:character/remove/this

# 清除場景實體
kill @e[tag=water2_entity]

# 結束時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode
