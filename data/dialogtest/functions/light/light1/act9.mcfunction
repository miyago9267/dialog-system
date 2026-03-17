# 光神往後跑走（line11）
# 光神在 -1765 facing -1772（面向玩家），往後跑 = 向東
execute as @e[tag=lightgod] run tp @s -1755 82 2112 0 0
execute as @e[tag=lightgod] at @s run tp @s ~ ~ ~ facing -1750 82 2112
tp @e[tag=light1_lightgod_name] -1755 84 2112
playsound minecraft:entity.player.attack.sweep ambient @a -1760 82 2112 1 1
