# 檢查fire1觸發條件 - 玩家在座標(-2031, 14, 1760)的半徑3格內
# 只有在舊版plot_test的fire1觸發點不存在時才觸發新版
execute unless score fire1_triggered fire_story matches 1 unless entity @e[tag=fire1,type=armor_stand] positioned -2031 14 1760 if entity @a[distance=..3] run function dialogtest:fire/fire1/start

# 檢查fire2觸發條件 - 玩家在座標(-2399, 18, 1727)的半徑3格內
execute unless score fire2_triggered fire_story matches 1 positioned -2399 18 1727 if entity @a[distance=..3] run function dialogtest:fire/fire2/start

# 檢查fire3觸發條件 - 透過trigger變數
# 使用方法：scoreboard players set fire3_trigger fire_story 1
execute if score fire3_trigger fire_story matches 1.. unless score fire3_triggered fire_story matches 1 run function dialogtest:fire/fire3/start
execute if score fire3_trigger fire_story matches 1.. unless score fire3_triggered fire_story matches 1 run scoreboard players set fire3_triggered fire_story 1
execute if score fire3_trigger fire_story matches 1.. unless score fire3_triggered fire_story matches 1 run scoreboard players set fire3_trigger fire_story 0
