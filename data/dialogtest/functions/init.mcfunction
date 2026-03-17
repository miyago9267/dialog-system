scoreboard objectives add dialog_timer dummy
scoreboard players set _playing dialog_timer 0
scoreboard players set _cd dialog_timer 0
scoreboard players set _wt dialog_timer 0
scoreboard players set _scene_tick dialog_timer 0
scoreboard players set _fire1_villager_walking dialog_timer 0

# 觸發點重置開關：_keep_triggers = 1 時 reload 不重置觸發紀錄（預設開啟）
# 關閉：/scoreboard players set _keep_triggers dialog_timer 0
# 開啟：/scoreboard players set _keep_triggers dialog_timer 1
execute unless score _keep_triggers dialog_timer matches 0.. run scoreboard players set _keep_triggers dialog_timer 1

# fire story triggers
scoreboard objectives add fire_story dummy
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set fire1_triggered fire_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set fire2_triggered fire_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set fire3_triggered fire_story 0
scoreboard players set fire3_trigger fire_story 0

# water story triggers
scoreboard objectives add water_story dummy
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set water1_triggered water_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set water2_triggered water_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set water3_triggered water_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set water4_triggered water_story 0
scoreboard players set water4_trigger water_story 0

# grass story triggers
scoreboard objectives add grass_story dummy
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set grass1_triggered grass_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set grass2_triggered grass_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set grass3_triggered grass_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set grass4_triggered grass_story 0
scoreboard players set grass4_trigger grass_story 0

# light story triggers
scoreboard objectives add light_story dummy
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set light1_triggered light_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set light2_triggered light_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set light3_triggered light_story 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set light4_triggered light_story 0
scoreboard players set light4_trigger light_story 0

# 跳過劇情 trigger（非 op 玩家可用）
scoreboard objectives add skip_scene trigger
scoreboard players set _skip_triggered dialog_timer 0

# 強制載入門模板區塊（clone 需要來源區塊在載入範圍）
# 模板位置: 水靈座門 (-1758~-1764, z=1392), 試煉門 (-1755, z=1376~1390)
forceload add -1764 1376 -1755 1392

data modify storage dialogtest:story run.playing set value 0b

