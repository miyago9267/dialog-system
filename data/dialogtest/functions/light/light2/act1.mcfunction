# 鏡頭從特寫後退至玩家視角（t=55）
tp @e[tag=scene_camera] -1835 32 2154 0 0
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1822 32 2154
tp @a -1835 32 2154 facing -1822 32 2154
