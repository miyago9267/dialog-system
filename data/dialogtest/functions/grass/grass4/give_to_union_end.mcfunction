# 花轉移至尤尼恩 + 收手
# action 軌 t=290

# 停止跟蹤
scoreboard players set _grass4_poppy_tracking dialog_timer 0

# 花粒子轉移至尤尼恩
particle minecraft:falling_spore_blossom -936 7 1925 0.3 0.3 0.3 0 10 force
particle minecraft:end_rod -936 7 1925 0.2 0.5 0.2 0.02 8 force
playsound minecraft:block.amethyst_block.chime ambient @a -936 6 1925 1 1.2

# 移除罌粟
kill @e[tag=grass4_poppy]

# 收手恢復呼吸
execute as @e[tag=woodgod] run function animated_java:character/animations/give/stop
execute as @e[tag=woodgod] run function animated_java:character/animations/breath/play
