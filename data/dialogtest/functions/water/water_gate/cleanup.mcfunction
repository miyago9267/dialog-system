# water_gate 場景清理

# 延後黑幕清除（讓玩家緩降落地再亮起）
schedule function dialogtest:operations/transition/fade_from_black 60t

# 解除玩家鎖定，緩降落地
effect give @a slow_falling 5 0 true
tp @a -1749 20 1541
gamemode adventure @a
kill @e[tag=scene_camera]

# 停止持續粒子
scoreboard players set _water_gate_fx dialog_timer 0

# 結束時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode
