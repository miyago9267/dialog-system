# 木神舉手送花給主角
# action 軌 t=330

# give 動畫（右手舉起）
execute as @e[tag=woodgod] run function animated_java:character/animations/breath/stop
execute as @e[tag=woodgod] run function animated_java:character/animations/give/play

# 召喚罌粟 item_display（初始在手臂旁，由 poppy_track 分段移動）
execute as @e[tag=woodgod] at @s run summon item_display ^-0.3 ^1.2 ^0.1 {item:{id:"minecraft:poppy",Count:1b},Tags:["grass4_entity","grass4_poppy"],billboard:"center",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.5f,0.5f,0.5f]}}

# 啟動跟蹤
scoreboard players set _grass4_poppy_tracking dialog_timer 1
scoreboard players set _grass4_poppy_tick dialog_timer 0
