# 檢查light1觸發條件 - 剛進入光源迷樓地下，座標待確認（暫定 0 0 0），半徑3格內
# TODO: 確認 light1 觸發座標後更新（或使用 tools/update_triggers.py）
execute unless score light1_triggered light_story matches 1 positioned 0 0 0 if entity @a[distance=..3] run function dialogtest:light/light1/start

# 檢查light2觸發條件 - 抵達光源試煉場，座標待確認（暫定 0 0 0），半徑3格內
# TODO: 確認 light2 觸發座標後更新（或使用 tools/update_triggers.py）
execute unless score light2_triggered light_story matches 1 positioned 0 0 0 if entity @a[distance=..3] run function dialogtest:light/light2/start

# 檢查light3觸發條件 - 抵達盡頭戰場，座標待確認（暫定 0 0 0），半徑3格內
# TODO: 確認 light3 觸發座標後更新（或使用 tools/update_triggers.py）
execute unless score light3_triggered light_story matches 1 positioned 0 0 0 if entity @a[distance=..3] run function dialogtest:light/light3/start

# 檢查light4觸發條件 - 擊敗光靈神後透過trigger變數觸發
# 使用方法：scoreboard players set light4_trigger light_story 1
execute if score light4_trigger light_story matches 1.. unless score light4_triggered light_story matches 1 run function dialogtest:light/light4/start
execute if score light4_trigger light_story matches 1.. unless score light4_triggered light_story matches 1 run scoreboard players set light4_triggered light_story 1
execute if score light4_trigger light_story matches 1.. unless score light4_triggered light_story matches 1 run scoreboard players set light4_trigger light_story 0
