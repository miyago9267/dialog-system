# 設置已觸發，防止重複執行
scoreboard players set water3_triggered water_story 1

data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.cd set value 1
data modify storage dialogtest:story run.chapter set value water
data modify storage dialogtest:story run.paragraph set value water3
data modify storage dialogtest:story run.dialog set value 0
