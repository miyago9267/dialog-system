# 設置已觸發，防止重複執行
scoreboard players set fire3_triggered fire_story 1
scoreboard players set fire3_trigger fire_story 0

data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.cd set value 1
data modify storage dialogtest:story run.chapter set value fire
data modify storage dialogtest:story run.paragraph set value fire3
data modify storage dialogtest:story run.dialog set value 0
