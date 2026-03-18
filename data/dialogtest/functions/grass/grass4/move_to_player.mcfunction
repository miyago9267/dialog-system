# 木神瞬移至主角旁（苞子粒子表現移動）
# action 軌 t=310

# 苞子粒子（出發點）
particle minecraft:spore_blossom_air -937 7 1925 0.3 0.5 0.3 0 15 force
particle minecraft:falling_spore_blossom -937 7 1925 0.3 0.3 0.3 0 10 force

# 瞬移到主角旁
execute as @e[tag=woodgod] run tp @s -934 6 1922 0 0
execute as @e[tag=woodgod] at @s run tp @s ~ ~ ~ facing -932 6 1922
tp @e[tag=grass4_woodgod_name] -934 8 1922

# 苞子粒子（到達點）
particle minecraft:spore_blossom_air -934 7 1922 0.3 0.5 0.3 0 15 force
particle minecraft:falling_spore_blossom -934 7 1922 0.3 0.3 0.3 0 10 force
playsound minecraft:block.amethyst_block.chime ambient @a -934 6 1922 1 1.0

# 尤尼恩轉向跟隨木神
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -934 6 1922
