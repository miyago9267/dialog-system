# 村民到達-2028 13 1769後的處理
# 轉向-2025 13 1771並發出叫聲

# 轉向目標位置
execute as @e[name="鐵匠賽克",tag=fire1] at @s run tp @s ~ ~ ~ facing -2025 13 1771

# 發出村民叫聲
execute as @e[type=minecraft:villager,name="鐵匠賽克",limit=1] at @s run playsound minecraft:entity.villager.ambient neutral @a ~ ~ ~ 1.0 1.0
