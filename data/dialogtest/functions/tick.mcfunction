# check fire story triggers
function dialogtest:fire/trigger

# check water story triggers
function dialogtest:water/trigger

# check grass story triggers
function dialogtest:grass/trigger

# check light story triggers
function dialogtest:light/trigger

# return while not playing
scoreboard players set _playing dialog_timer 0
execute if data storage dialogtest:story run.playing run execute store result score _playing dialog_timer run data get storage dialogtest:story run.playing 1
execute unless score _playing dialog_timer matches 1 run return 0

# 檢測跳過觸發（trigger）
scoreboard players set _skip_triggered dialog_timer 0
execute if entity @a[scores={skip_scene=1..}] run scoreboard players set _skip_triggered dialog_timer 1
scoreboard players set @a[scores={skip_scene=1..}] skip_scene 0
execute if score _skip_triggered dialog_timer matches 1 run function dialogtest:skip
execute if score _skip_triggered dialog_timer matches 1 run return 0

# ── 新：時間軸模式（fire1 等） ──────────────────────────────
execute if data storage dialogtest:story {run:{mode:"timeline"}} run function dialogtest:operations/timeline/tick
execute if data storage dialogtest:story {run:{mode:"timeline"}} run return 1

# ── 舊：N.mcfunction 模式（fire2/fire3/water/palace 等） ────
# countdown
scoreboard players set _cd dialog_timer 0
execute store result score _cd dialog_timer run data get storage dialogtest:story run.cd 1
execute if score _cd dialog_timer matches 1.. run scoreboard players remove _cd dialog_timer 1
execute if score _cd dialog_timer matches 1.. run execute store result storage dialogtest:story run.cd int 1 run scoreboard players get _cd dialog_timer
execute if score _cd dialog_timer matches 1.. run return 0

execute if score _playing dialog_timer matches 1 if data storage dialogtest:story run.chapter run function dialogtest:list with storage dialogtest:story run

# set delay time
scoreboard players set _wt dialog_timer 0
execute store result score _wt dialog_timer run data get storage dialogtest:story current.wait.ticks 1
execute if score _wt dialog_timer matches 1.. run execute store result storage dialogtest:story run.cd int 1 run scoreboard players get _wt dialog_timer

return 1
