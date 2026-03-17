# 木神移至尤尼恩旁，準備送花
# 觸發時機：t=185（line3: 旁白送花）

# 木神移動至尤尼恩旁
execute as @e[tag=woodgod] run tp @s -937 6 1925 0 0
execute as @e[tag=woodgod] at @s run tp @s ~ ~ ~ facing -936 6 1925

# 移動名牌
tp @e[tag=grass4_woodgod_name] -937 8 1925
