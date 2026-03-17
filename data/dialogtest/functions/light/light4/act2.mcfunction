# 退回至主角視角（line6）
tp @e[tag=scene_camera] -1699 28 2154 0 0
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1687 28 2154
tp @a -1699 28 2154 facing -1687 28 2154
