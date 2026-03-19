# 每 tick 讓罌粟沿弧形軌跡抬起（配合 give 動畫手臂運動）
# 由 tick.mcfunction 在 _grass4_poppy_tracking=1 時呼叫
#
# 軌跡根據 give 動畫 right_arm 骨骼旋轉計算：
#   frame 0:  手垂在身旁  Y≈0.8  Z≈0.0
#   frame 3:  開始抬      Y≈0.85 Z≈0.15
#   frame 7:  抬到一半    Y≈0.95 Z≈0.35
#   frame 10: 接近前伸    Y≈1.05 Z≈0.5
#   frame 14: 完全伸出    Y≈1.15 Z≈0.6

scoreboard players add _grass4_poppy_tick dialog_timer 1

execute if score _grass4_poppy_tick dialog_timer matches 1..3 as @e[tag=woodgod] at @s run tp @e[tag=grass4_poppy] ^-0.3 ^1.3 ^0.15
execute if score _grass4_poppy_tick dialog_timer matches 4..6 as @e[tag=woodgod] at @s run tp @e[tag=grass4_poppy] ^-0.3 ^1.35 ^0.25
execute if score _grass4_poppy_tick dialog_timer matches 7..9 as @e[tag=woodgod] at @s run tp @e[tag=grass4_poppy] ^-0.3 ^1.45 ^0.45
execute if score _grass4_poppy_tick dialog_timer matches 10..12 as @e[tag=woodgod] at @s run tp @e[tag=grass4_poppy] ^-0.3 ^1.55 ^0.6
execute if score _grass4_poppy_tick dialog_timer matches 13.. as @e[tag=woodgod] at @s run tp @e[tag=grass4_poppy] ^-0.3 ^1.65 ^0.7
