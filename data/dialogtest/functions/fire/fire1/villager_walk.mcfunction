# 讓鐵匠賽克慢慢走向目標位置
# 對話10: -2029 13 1767 -> -2028 13 1769
# 對話12: -2028 13 1769 -> -2030 13 1759

# 鎖定玩家視角在村民初始位置
tp @a -2032 13 1765 facing -2029 13 1767

# 獲取當前對話編號
scoreboard players set _current_dialog dialog_timer 0
execute store result score _current_dialog dialog_timer run data get storage dialogtest:story run.dialog 1

# 對話10: 移動到 -2028 13 1769
execute if score _current_dialog dialog_timer matches 10 as @e[name="鐵匠賽克",tag=fire1] at @s if entity @s[x=-2028,y=13,z=1769,distance=..0.3] run function dialogtest:fire/fire1/villager_arrived_10
execute if score _current_dialog dialog_timer matches 10 as @e[name="鐵匠賽克",tag=fire1] at @s unless entity @s[x=-2028,y=13,z=1769,distance=..0.3] run function dialogtest:fire/fire1/villager_walk_step_10

# 對話12及之後: 從 -2028 13 1769 移動到 -2030 13 1759
execute if score _current_dialog dialog_timer matches 12.. as @e[name="鐵匠賽克",tag=fire1] at @s unless entity @s[x=-2030,y=13,z=1759,distance=..0.3] run function dialogtest:fire/fire1/villager_walk_step
