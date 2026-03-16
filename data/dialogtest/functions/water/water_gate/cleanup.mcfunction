# water_gate 場景清理

# 解除玩家鎖定
gamemode adventure @a
kill @e[tag=scene_camera]

# 停止持續粒子
scoreboard players set _water_gate_fx dialog_timer 0

# 結束時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode
