# fire1 場景清理（ctrl 軌 t=600 觸發）

# 解除玩家鎖定
gamemode adventure @a
kill @e[tag=scene_camera]

# 停止村民移動
scoreboard players set _fire1_villager_walking dialog_timer 0
data modify storage dialogtest:story run.villager_walk_phase set value 0

# 清除角色和場景實體
execute as @e[tag=union] run function animated_java:character/remove/this
tp @e[name="鐵匠賽克"] -2029 -64 1767
kill @e[tag=fire1]

# 結束時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode
