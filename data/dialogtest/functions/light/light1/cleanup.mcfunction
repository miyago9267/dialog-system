# light1 場景清理（ctrl 軌觸發）

# 緩降保護
effect give @a slow_falling 5 0 true

# 解除玩家鎖定
gamemode adventure @a
kill @e[tag=scene_camera]

# 移除 AJ 角色
execute as @e[tag=lightgod] run function animated_java:character/remove/this
execute as @e[tag=union] run function animated_java:character/remove/this

# 清除場景實體
kill @e[tag=light1_entity]

# 結束時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode

# 淡出黑幕
schedule function dialogtest:operations/transition/fade_from_black 60t
