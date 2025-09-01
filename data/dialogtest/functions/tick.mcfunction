# return while not playing
scoreboard players set _playing dialog_timer 0
execute if data storage dialogtest:story run.playing run execute store result score _playing dialog_timer run data get storage dialogtest:story run.playing 1
execute unless score _playing dialog_timer matches 1 run return 0

# countdown
scoreboard players set _cd dialog_timer 0
execute store result score _cd dialog_timer run data get storage dialogtest:story run.cd 1
execute if score _cd dialog_timer matches 1.. run scoreboard players remove _cd dialog_timer 1
execute if score _cd dialog_timer matches 1.. run execute store result storage dialogtest:story run.cd int 1 run scoreboard players get _cd dialog_timer
execute if score _cd dialog_timer matches 1.. run return 0

# get front of queue
execute unless data storage dialogtest:story chapters.chapter1[0] run data modify storage dialogtest:story run.playing set value 0b
execute unless data storage dialogtest:story chapters.chapter1[0] run return 0
data modify storage dialogtest:story current set from storage dialogtest:story chapters.chapter1[0]

# call method by op
execute if data storage dialogtest:story current{op:"tellraw"} run function dialogtest:operations/tellraw
execute if data storage dialogtest:story current{op:"tp"} run function dialogtest:operations/tp
execute if data storage dialogtest:story current{op:"cmd"} run function dialogtest:operations/cmd
execute if data storage dialogtest:story current{op:"aj_play"} run function dialogtest:operations/aj
execute if data storage dialogtest:story current{op:"wait"} run function dialogtest:operations/wait
## could extended

# set delay time
scoreboard players set _wt dialog_timer 0
execute store result score _wt dialog_timer run data get storage dialogtest:story current.wait.ticks 1
execute if score _wt dialog_timer matches 1.. run execute store result storage dialogtest:story run.cd int 1 run scoreboard players get _wt dialog_timer

# pop front of queue
data remove storage dialogtest:story chapters.chapter1[0]

# return success
return 1
