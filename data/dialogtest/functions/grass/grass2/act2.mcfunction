# 動作：麥洛倪雅莎化成苞子花粒子消失
# 觸發時機：t=425 (line6)

# 苞子花粒子爆發
particle minecraft:spore_blossom_air -1215 6 1794 0.3 0.8 0.3 0 30 force
particle minecraft:falling_spore_blossom -1215 7 1794 0.5 0.3 0.5 0 20 force
particle minecraft:end_rod -1215 6 1794 0.3 1.0 0.3 0.05 15 force
playsound minecraft:block.amethyst_block.break ambient @a -1215 6 1794 2 0.8

# 移除木神
execute as @e[tag=woodgod] run function animated_java:character/remove/this
kill @e[tag=grass2_entity,name="木神"]
