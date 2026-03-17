# 檢查water1觸發條件 - 玩家抵達水源大堂 (-1749, 74, 1502) 半徑3格內
# 延遲1t啟動，避免同tick執行導致AJ材質未載入
execute unless score water1_triggered story_progress matches 1 positioned -1749 74 1502 if entity @a[distance=..3] run schedule function dialogtest:water/water1/start 1t
execute unless score water1_triggered story_progress matches 1 positioned -1749 74 1502 if entity @a[distance=..3] run scoreboard players set water1_triggered story_progress 1

# 檢查water2觸發條件 - 玩家抵達水靈座 (-1749, 12, 1556) 半徑3格內
execute unless score water2_triggered story_progress matches 1 positioned -1749 12 1556 if entity @a[distance=..3] run schedule function dialogtest:water/water2/start 1t
execute unless score water2_triggered story_progress matches 1 positioned -1749 12 1556 if entity @a[distance=..3] run scoreboard players set water2_triggered story_progress 1

# 檢查water3觸發條件 - 解開四重謎題後回到水靈座 (-1749, 12, 1570) 半徑3格內
# 需要先完成water2才能觸發
execute unless score water3_triggered story_progress matches 1 if score water2_triggered story_progress matches 1 positioned -1749 12 1570 if entity @a[distance=..3] run schedule function dialogtest:water/water3/start 1t
execute unless score water3_triggered story_progress matches 1 if score water2_triggered story_progress matches 1 positioned -1749 12 1570 if entity @a[distance=..3] run scoreboard players set water3_triggered story_progress 1

# 檢查water4觸發條件 - 擊敗BOSS奈迪拉提雅後透過trigger變數觸發
# 使用方法：scoreboard players set water4_trigger story_progress 1
execute if score water4_trigger story_progress matches 1.. unless score water4_triggered story_progress matches 1 run schedule function dialogtest:water/water4/start 1t
execute if score water4_trigger story_progress matches 1.. unless score water4_triggered story_progress matches 1 run scoreboard players set water4_triggered story_progress 1
execute if score water4_trigger story_progress matches 1.. unless score water4_triggered story_progress matches 1 run scoreboard players set water4_trigger story_progress 0

# 檢查water_gate觸發條件 - 完成四道試煉後玩家抵達 (-1749, 20, 1541) 半徑3格內
execute unless score water_gate_triggered story_progress matches 1 if score water4_triggered story_progress matches 1 positioned -1749 20 1541 if entity @a[distance=..3] run schedule function dialogtest:water/water_gate/start 1t
execute unless score water_gate_triggered story_progress matches 1 if score water4_triggered story_progress matches 1 positioned -1749 20 1541 if entity @a[distance=..3] run scoreboard players set water_gate_triggered story_progress 1
