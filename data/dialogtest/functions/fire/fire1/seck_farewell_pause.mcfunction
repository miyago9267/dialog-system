# 賽克告別：暫停移動，轉向看玩家
# villager 軌 t=1000（line13 文字出現 0.75 秒後）
scoreboard players set _fire1_villager_walking dialog_timer 0
execute as @e[name="鐵匠賽克",tag=fire1] at @s run tp @s ~ ~ ~ facing -2032 13 1763
