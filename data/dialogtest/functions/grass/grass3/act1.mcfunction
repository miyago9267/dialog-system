# 鏡頭拉到主角視角位置
# 觸發時機：t=55（木神點頭後）

tp @e[tag=scene_camera] -932 6 1922 0 0
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -954 6 1922
tp @a -932 6 1922 facing -954 6 1922
