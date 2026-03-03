# fire2 跳過劇情（測試用）
# 一次吐出所有對話文本，然後直接清理

# 清屏
tellraw @a {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}

# 劇情總文本
tellraw @a ["",{"text":"--------[","bold":true},{"text":"fire2 劇情總文本","color":"#A7A7A7"},{"text":"]--------","bold":true}]
tellraw @a {"translate":"story.fire.fire2.line3"}
tellraw @a {"translate":"story.fire.fire2.line4"}
tellraw @a {"translate":"story.fire.fire2.line5","with":[{"selector":"@e[tag=PlayerName]","color":"aqua"}]}
tellraw @a {"translate":"story.fire.fire2.line6"}
tellraw @a {"translate":"story.fire.fire2.line7"}

# 直接執行清理（跳過所有特效）
function dialogtest:fire/fire2/cleanup
