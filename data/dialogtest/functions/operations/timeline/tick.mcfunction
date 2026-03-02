# 時間軸模式的每 tick 驅動
# 由 tick.mcfunction 在 run.mode = "timeline" 時呼叫

# scene_tick +1，並同步到 storage
scoreboard players add _scene_tick dialog_timer 1
execute store result storage dialogtest:story run.scene_tick int 1 run scoreboard players get _scene_tick dialog_timer

# 持續動作：fire1 村民移動
execute if score _fire1_villager_walking dialog_timer matches 1 run function dialogtest:fire/fire1/villager_walk

# 推進各軌道（以 _tl_args 傳入軌道路徑，各自獨立推進）
data modify storage dialogtest:story _tl_args set value {track:"run.text"}
execute if data storage dialogtest:story run.text[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args

data modify storage dialogtest:story _tl_args set value {track:"run.union"}
execute if data storage dialogtest:story run.union[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args

data modify storage dialogtest:story _tl_args set value {track:"run.villager"}
execute if data storage dialogtest:story run.villager[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args

data modify storage dialogtest:story _tl_args set value {track:"run.ctrl"}
execute if data storage dialogtest:story run.ctrl[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args
