# 檢查light1觸發條件 - 玩家進入光源迷樓 (-1775, 82, 2112) 半徑3格內
execute unless score light1_triggered light_story matches 1 positioned -1775 82 2112 if entity @a[distance=..3] run function dialogtest:light/light1/start

# 檢查light2觸發條件 - 抵達光源試煉場 (-1835, 32, 2154) 半徑3格內
execute unless score light2_triggered light_story matches 1 positioned -1835 32 2154 if entity @a[distance=..3] run function dialogtest:light/light2/start

# 檢查light3觸發條件 - 抵達盡頭戰場 (-1707, 31, 2154) 半徑3格內
execute unless score light3_triggered light_story matches 1 positioned -1707 31 2154 if entity @a[distance=..3] run function dialogtest:light/light3/start

# 檢查light4觸發條件 - 擊敗光靈神後透過trigger變數觸發
# 使用方法：scoreboard players set light4_trigger light_story 1
execute if score light4_trigger light_story matches 1.. unless score light4_triggered light_story matches 1 run function dialogtest:light/light4/start
execute if score light4_trigger light_story matches 1.. unless score light4_triggered light_story matches 1 run scoreboard players set light4_triggered light_story 1
execute if score light4_trigger light_story matches 1.. unless score light4_triggered light_story matches 1 run scoreboard players set light4_trigger light_story 0
