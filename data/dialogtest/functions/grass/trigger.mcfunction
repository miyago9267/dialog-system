# 檢查grass1觸發條件 - 玩家抵達木源入口 (-1413, 6, 1870) 半徑3格內
execute unless score grass1_triggered grass_story matches 1 positioned -1413 6 1870 if entity @a[distance=..3] run function dialogtest:grass/grass1/start

# 檢查grass2觸發條件 - 座標待確認（暫定 0 0 0），半徑3格內
# TODO: 確認 grass2 觸發座標後更新
execute unless score grass2_triggered grass_story matches 1 positioned 0 0 0 if entity @a[distance=..3] run function dialogtest:grass/grass2/start

# 檢查grass3觸發條件 - 玩家抵達指定位置 (-916, 6, 1916) 半徑3格內
execute unless score grass3_triggered grass_story matches 1 positioned -916 6 1916 if entity @a[distance=..3] run function dialogtest:grass/grass3/start

# 檢查grass4觸發條件 - 擊敗BOSS麥洛倪雅莎後透過trigger變數觸發
# 使用方法：scoreboard players set grass4_trigger grass_story 1
execute if score grass4_trigger grass_story matches 1.. unless score grass4_triggered grass_story matches 1 run function dialogtest:grass/grass4/start
execute if score grass4_trigger grass_story matches 1.. unless score grass4_triggered grass_story matches 1 run scoreboard players set grass4_triggered grass_story 1
execute if score grass4_trigger grass_story matches 1.. unless score grass4_triggered grass_story matches 1 run scoreboard players set grass4_trigger grass_story 0
