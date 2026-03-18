# 木神舉手送花給主角
# action 軌 t=330

# give 動畫（右手舉起）
execute as @e[tag=woodgod] run function animated_java:character/animations/breath/stop
execute as @e[tag=woodgod] run function animated_java:character/animations/give/play

# 在木神根實體位置召喚罌粟（每 tick 由 poppy_track 跟隨右手骨骼）
execute at @e[tag=woodgod] run summon item_display ~ ~ ~ {item:{id:"minecraft:poppy",Count:1b},Tags:["grass4_entity","grass4_poppy"],billboard:"fixed",transformation:{left_rotation:[0f,0f,0f,1f],right_rotation:[0f,0f,0f,1f],translation:[0f,0f,0f],scale:[0.5f,0.5f,0.5f]}}

# 啟動罌粟跟蹤
scoreboard players set _grass4_poppy_tracking dialog_timer 1
