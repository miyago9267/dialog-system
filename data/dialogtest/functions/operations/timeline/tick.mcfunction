# 時間軸模式的每 tick 驅動
# 由 tick.mcfunction 在 run.mode = "timeline" 時呼叫

# scene_tick +1，並同步到 storage
scoreboard players add _scene_tick dialog_timer 1
execute store result storage dialogtest:story run.scene_tick int 1 run scoreboard players get _scene_tick dialog_timer

# 第一 tick：開場黑幕 + 觀察者模式
execute if score _scene_tick dialog_timer matches 1 run effect give @a darkness 999 1 true
execute if score _scene_tick dialog_timer matches 1 run effect give @a blindness 999 0 true
execute if score _scene_tick dialog_timer matches 1 run gamemode spectator @a

# tick 25：清除黑幕、啟用跳過按鈕、所有 AJ 角色開始呼吸
execute if score _scene_tick dialog_timer matches 25 run function dialogtest:operations/transition/fade_from_black
execute if score _scene_tick dialog_timer matches 25 run scoreboard players enable @a skip_scene
execute if score _scene_tick dialog_timer matches 25 run tellraw @a ["",{"text":"       "},{"text":"[跳過劇情]","color":"gray","italic":true,"clickEvent":{"action":"run_command","value":"/trigger skip_scene set 1"},"hoverEvent":{"action":"show_text","value":{"text":"點擊跳過目前劇情"}}}]
execute if score _scene_tick dialog_timer matches 25 as @e[tag=aj.character.root] run function animated_java:character/animations/breath/play

# 每 tick 鎖定玩家位置（tp 到 scene_camera marker）
execute at @e[tag=scene_camera,limit=1] run tp @a ~ ~ ~ ~ ~

# 持續動作：fire1 村民移動（僅 fire1 場景）
execute if score _fire1_villager_walking dialog_timer matches 1 if data storage dialogtest:story {run:{scene:"fire1"}} run function dialogtest:fire/fire1/villager_walk

# 持續動作：fire2 特效（火柱旋轉粒子、中央火焰、玩家鎖定等）
execute if data storage dialogtest:story {run:{scene:"fire_fire2"}} run function dialogtest:fire/fire2/effects_tick

# 推進各軌道（以 _tl_args 傳入軌道路徑，各自獨立推進）
data modify storage dialogtest:story _tl_args set value {track:"run.text"}
execute if data storage dialogtest:story run.text[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args

data modify storage dialogtest:story _tl_args set value {track:"run.union"}
execute if data storage dialogtest:story run.union[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args

data modify storage dialogtest:story _tl_args set value {track:"run.villager"}
execute if data storage dialogtest:story run.villager[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args

data modify storage dialogtest:story _tl_args set value {track:"run.action"}
execute if data storage dialogtest:story run.action[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args

data modify storage dialogtest:story _tl_args set value {track:"run.ctrl"}
execute if data storage dialogtest:story run.ctrl[0] run function dialogtest:operations/timeline/advance with storage dialogtest:story _tl_args
