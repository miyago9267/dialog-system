# 鐵匠賽克移動（每 tick 由 operations/timeline/tick 在 _fire1_villager_walking=1 時呼叫）
# 移動目標由 run.villager_walk_phase 決定（由 villager 軌事件設定）

# 鎖定玩家視角
tp @a -2032 13 1765 facing -2029 13 1767

# Phase 1：走向 -2028 13 1769（靜水台入口）
execute if data storage dialogtest:story {run:{villager_walk_phase:1}} \
    as @e[name="鐵匠賽克",tag=fire1] at @s \
    if entity @s[x=-2028,y=13,z=1769,distance=..0.3] \
    run function dialogtest:fire/fire1/villager_arrived_10
execute if data storage dialogtest:story {run:{villager_walk_phase:1}} \
    as @e[name="鐵匠賽克",tag=fire1] at @s \
    unless entity @s[x=-2028,y=13,z=1769,distance=..0.3] \
    run function dialogtest:fire/fire1/villager_walk_step_10

# Phase 2：走向 -2030 13 1759（靜水台深處）
execute if data storage dialogtest:story {run:{villager_walk_phase:2}} \
    as @e[name="鐵匠賽克",tag=fire1] at @s \
    unless entity @s[x=-2030,y=13,z=1759,distance=..0.3] \
    run function dialogtest:fire/fire1/villager_walk_step
