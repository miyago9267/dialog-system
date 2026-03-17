# 木神從 -954 移動至 -945，轉向面對玩家方向
# 觸發時機：t=105（line2: 打敗，我）

# 移動木神
execute as @e[tag=woodgod] run tp @s -945 6 1922 0 0
execute as @e[tag=woodgod] at @s run tp @s ~ ~ ~ facing -932 6 1922

# 移動名牌
tp @e[tag=grass3_entity,name="木神"] -945 8 1922
