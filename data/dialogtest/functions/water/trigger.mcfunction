# 檢查water1觸發條件 - 玩家抵達水源大堂 (-1749, 12, 1492) 半徑3格內
execute unless score water1_triggered water_story matches 1 positioned -1749 12 1492 if entity @a[distance=..3] run function dialogtest:water/water1/start

# 檢查water2觸發條件 - 玩家抵達水靈座 (-1749, 12, 1556) 半徑3格內
execute unless score water2_triggered water_story matches 1 positioned -1749 12 1556 if entity @a[distance=..3] run function dialogtest:water/water2/start

# 檢查water3觸發條件 - 解開四重謎題後回到水靈座 (-1749, 12, 1570) 半徑3格內
# 需要先完成water2才能觸發
execute unless score water3_triggered water_story matches 1 if score water2_triggered water_story matches 1 positioned -1749 12 1570 if entity @a[distance=..3] run function dialogtest:water/water3/start

# 檢查water4觸發條件 - 擊敗BOSS奈迪拉提雅後透過trigger變數觸發
# 使用方法：scoreboard players set water4_trigger water_story 1
execute if score water4_trigger water_story matches 1.. unless score water4_triggered water_story matches 1 run function dialogtest:water/water4/start
execute if score water4_trigger water_story matches 1.. unless score water4_triggered water_story matches 1 run scoreboard players set water4_triggered water_story 1
execute if score water4_trigger water_story matches 1.. unless score water4_triggered water_story matches 1 run scoreboard players set water4_trigger water_story 0
