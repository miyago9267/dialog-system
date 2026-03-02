scoreboard objectives add dialog_timer dummy
scoreboard players set _playing dialog_timer 0
scoreboard players set _cd dialog_timer 0
scoreboard players set _wt dialog_timer 0

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

data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.cd set value 1
data modify storage dialogtest:story run.chapter set value 0
data modify storage dialogtest:story run.paragraph set value 0
data modify storage dialogtest:story run.dialog set value 0

