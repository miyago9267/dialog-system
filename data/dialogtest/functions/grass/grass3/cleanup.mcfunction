# grass3 場景清理 → BOSS 戰轉場

# 緩降保護
effect give @a slow_falling 5 0 true

# 解除玩家鎖定（進入 BOSS 戰）
gamemode adventure @a
kill @e[tag=scene_camera]

# 移除尤尼恩（木神保留作為 BOSS）
execute as @e[tag=union] run function animated_java:character/remove/this

# 清除場景名牌
kill @e[tag=grass3_entity]

# 結束時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode

# 淡出黑幕
schedule function dialogtest:operations/transition/fade_from_black 60t
