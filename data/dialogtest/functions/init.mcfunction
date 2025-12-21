scoreboard objectives add dialog_timer dummy
scoreboard players set _playing dialog_timer 0
scoreboard players set _cd dialog_timer 0
scoreboard players set _wt dialog_timer 0

data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.cd set value 1
data modify storage dialogtest:story run.chapter set value 0
data modify storage dialogtest:story run.paragraph set value 0
data modify storage dialogtest:story run.dialog set value 0

