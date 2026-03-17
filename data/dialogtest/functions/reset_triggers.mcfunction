# 強制載入門模板區塊（clone 需要來源區塊載入）
forceload add -1764 1376 -1755 1392

# 手動重置全部觸發紀錄
scoreboard players set fire1_triggered fire_story 0
scoreboard players set fire2_triggered fire_story 0
scoreboard players set fire3_triggered fire_story 0
scoreboard players set water1_triggered water_story 0
scoreboard players set water2_triggered water_story 0
scoreboard players set water3_triggered water_story 0
scoreboard players set water4_triggered water_story 0
scoreboard players set water_gate_triggered water_story 0
# 延遲 1 tick 還原門（等 forceload 生效）
schedule function dialogtest:close_doors 1t
scoreboard players set grass1_triggered grass_story 0
scoreboard players set grass2_triggered grass_story 0
scoreboard players set grass3_triggered grass_story 0
scoreboard players set grass4_triggered grass_story 0
scoreboard players set light1_triggered light_story 0
scoreboard players set light2_triggered light_story 0
scoreboard players set light3_triggered light_story 0
scoreboard players set light4_triggered light_story 0
tellraw @s {"text":"已重置全部觸發點","color":"green"}
