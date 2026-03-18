# 木神瞬移至尤尼恩旁（苞子粒子表現移動）
# action 軌 t=195

# 苞子粒子（出發點）
particle minecraft:spore_blossom_air -945 7 1922 0.3 0.5 0.3 0 15 force
particle minecraft:falling_spore_blossom -945 7 1922 0.3 0.3 0.3 0 10 force

# 瞬移到尤尼恩旁
execute as @e[tag=woodgod] run tp @s -937 6 1925 0 0
execute as @e[tag=woodgod] at @s run tp @s ~ ~ ~ facing -936 6 1925
tp @e[tag=grass4_woodgod_name] -937 8 1925

# 苞子粒子（到達點）
particle minecraft:spore_blossom_air -937 7 1925 0.3 0.5 0.3 0 15 force
particle minecraft:falling_spore_blossom -937 7 1925 0.3 0.3 0.3 0 10 force
playsound minecraft:block.amethyst_block.chime ambient @a -937 6 1925 1 1.0
