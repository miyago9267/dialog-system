# 花轉移至尤尼恩 + 木神移向主角
# 觸發時機：t=245

# 花粒子轉移至尤尼恩
particle minecraft:falling_spore_blossom -936 7 1925 0.3 0.3 0.3 0 10 force
particle minecraft:end_rod -936 7 1925 0.2 0.5 0.2 0.02 8 force
playsound minecraft:block.amethyst_block.chime ambient @a -936 6 1925 1 1.2

# 木神移向主角方向
execute as @e[tag=woodgod] run tp @s -934 6 1922 0 0
execute as @e[tag=woodgod] at @s run tp @s ~ ~ ~ facing -932 6 1922
tp @e[tag=grass4_woodgod_name] -934 8 1922

# 尤尼恩轉向跟隨木神
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -934 6 1922
