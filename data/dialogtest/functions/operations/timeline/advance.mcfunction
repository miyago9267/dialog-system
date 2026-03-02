# 推進單一軌道（macro）
# 呼叫方式：function ... with storage dialogtest:story _tl_args
# _tl_args = {track: "run.text"}  （軌道在 storage run 下的路徑）
#
# 注意：_tl_args 在整個遞迴期間不得被外部修改，
#       tick.mcfunction 在每次 function 呼叫完全結束後才更改 _tl_args

# 軌道沒有事件 → 結束
$execute unless data storage dialogtest:story $(track)[0] run return 0

# 下一個事件尚未到時間 → 結束
$execute store result score #tl_t temp run data get storage dialogtest:story $(track)[0].t
execute if score #tl_t temp > _scene_tick dialog_timer run return 0

# 取出事件（pop）
$data modify storage dialogtest:story run.current_event set from storage dialogtest:story $(track)[0]
$data remove storage dialogtest:story $(track)[0]

# 派發事件
function dialogtest:operations/timeline/dispatch_event

# 遞迴：同一 tick 可能有多個事件
function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args
