# 時間軸模式的每 tick 驅動
# 由 tick.mcfunction 在 run.mode = "timeline" 時呼叫

# scene_tick +1，並同步到 storage
scoreboard players add _scene_tick dialog_timer 1
execute store result storage dialogtest:story run.scene_tick int 1 run scoreboard players get _scene_tick dialog_timer

# 第一 tick 啟用 trigger 並顯示跳過按鈕（在文本軌推進前，確保按鈕出現在第一句台詞上方）
execute if score _scene_tick dialog_timer matches 1 run scoreboard players enable @a skip_scene
execute if score _scene_tick dialog_timer matches 1 run tellraw @a ["",{"text":"       "},{"text":"[跳過劇情]","color":"gray","italic":true,"clickEvent":{"action":"run_command","value":"/trigger skip_scene set 1"},"hoverEvent":{"action":"show_text","value":{"text":"點擊跳過目前劇情"}}}]

# 持續動作：fire1 村民移動
execute if score _fire1_villager_walking dialog_timer matches 1 run function dialogtest:fire/fire1/villager_walk

# 持續動作：fire2 特效（火柱旋轉粒子、中央火焰、玩家鎖定等）
execute if data storage dialogtest:story {run:{scene:"fire_fire2"}} run function dialogtest:fire/fire2/effects_tick

# 推進各軌道（以 _tl_args 傳入軌道路徑，各自獨立推進）
data modify storage dialogtest:story _tl_args set value {track:"run.text"}
execute if data storage dialogtest:story run.text[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args

data modify storage dialogtest:story _tl_args set value {track:"run.union"}
execute if data storage dialogtest:story run.union[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args

data modify storage dialogtest:story _tl_args set value {track:"run.villager"}
execute if data storage dialogtest:story run.villager[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args

data modify storage dialogtest:story _tl_args set value {track:"run.ctrl"}
execute if data storage dialogtest:story run.ctrl[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args
