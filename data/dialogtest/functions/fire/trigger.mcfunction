# 檢查fire1觸發條件 - 玩家在座標(-2031, 13, 1759)的半徑3格內
# 延遲1t啟動，避免同tick執行導致AJ材質未載入
execute unless score fire1_triggered fire_story matches 1 positioned -2031 13 1759 if entity @a[distance=..3] run schedule function dialogtest:fire/fire1/start 1t
execute unless score fire1_triggered fire_story matches 1 positioned -2031 13 1759 if entity @a[distance=..3] run scoreboard players set fire1_triggered fire_story 1

# 檢查fire2觸發條件 - 玩家在座標(-2399, 18, 1727)的半徑3格內
execute unless score fire2_triggered fire_story matches 1 positioned -2399 18 1727 if entity @a[distance=..3] run schedule function dialogtest:fire/fire2/start 1t
execute unless score fire2_triggered fire_story matches 1 positioned -2399 18 1727 if entity @a[distance=..3] run scoreboard players set fire2_triggered fire_story 1

# 檢查fire3觸發條件 - 透過trigger變數
# 使用方法：scoreboard players set fire3_trigger fire_story 1
execute if score fire3_trigger fire_story matches 1.. unless score fire3_triggered fire_story matches 1 run schedule function dialogtest:fire/fire3/start 1t
execute if score fire3_trigger fire_story matches 1.. unless score fire3_triggered fire_story matches 1 run scoreboard players set fire3_triggered fire_story 1
execute if score fire3_trigger fire_story matches 1.. unless score fire3_triggered fire_story matches 1 run scoreboard players set fire3_trigger fire_story 0
