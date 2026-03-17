# 主角視角看向迷樓（line6 第一段）
# 從特寫位置退回，面向迷樓入口
tp @e[tag=scene_camera] -1772 82 2112 0 0
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -1762 95 2118
tp @a -1772 82 2112 facing -1762 95 2118
