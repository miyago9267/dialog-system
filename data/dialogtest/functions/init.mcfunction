scoreboard objectives add dialog_timer dummy
scoreboard players set _playing dialog_timer 0
scoreboard players set _cd dialog_timer 0
scoreboard players set _wt dialog_timer 0
scoreboard players set _scene_tick dialog_timer 0
scoreboard players set _fire1_villager_walking dialog_timer 0

# fire story triggers
scoreboard objectives add fire_story dummy
scoreboard players set fire1_triggered fire_story 0
scoreboard players set fire2_triggered fire_story 0
scoreboard players set fire3_triggered fire_story 0
scoreboard players set fire3_trigger fire_story 0

# water story triggers
scoreboard objectives add water_story dummy
scoreboard players set water1_triggered water_story 0
scoreboard players set water2_triggered water_story 0
scoreboard players set water3_triggered water_story 0
scoreboard players set water4_triggered water_story 0
scoreboard players set water4_trigger water_story 0

# 跳過劇情 trigger（非 op 玩家可用）
scoreboard objectives add skip_scene trigger
scoreboard players set _skip_triggered dialog_timer 0

data modify storage dialogtest:story run.playing set value 0b

