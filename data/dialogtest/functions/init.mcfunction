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

# 劇情進度記分板（統一）
scoreboard objectives add story_progress dummy "Story Progress"
scoreboard objectives setdisplay sidebar story_progress

# fire triggers
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set fire1_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set fire2_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set fire3_triggered story_progress 0
scoreboard players set fire3_trigger story_progress 0

# water triggers
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set water1_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set water2_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set water3_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set water4_triggered story_progress 0
scoreboard players set water4_trigger story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set water_gate_triggered story_progress 0

# grass triggers
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set grass1_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set grass2_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set grass3_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set grass4_triggered story_progress 0
scoreboard players set grass4_trigger story_progress 0

# light triggers
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set light1_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set light2_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set light3_triggered story_progress 0
execute unless score _keep_triggers dialog_timer matches 1 run scoreboard players set light4_triggered story_progress 0
scoreboard players set light4_trigger story_progress 0

# 跳過劇情 trigger（非 op 玩家可用）
scoreboard objectives add skip_scene trigger
scoreboard players set _skip_triggered dialog_timer 0

# 強制載入門模板區塊（clone 需要來源區塊在載入範圍）
# 模板位置: 水靈座門 (-1758~-1764, z=1392), 試煉門 (-1755, z=1376~1390)
forceload add -1764 1376 -1755 1392

# 啟動暖機：等待 100 tick (5秒) 讓客戶端載入資源包模型
scoreboard players set _warmup dialog_timer 100

data modify storage dialogtest:story run.playing set value 0b

