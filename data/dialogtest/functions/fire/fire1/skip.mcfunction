# fire1 跳過劇情（測試用）
# 一次吐出所有對話文本，然後直接清理

# 清屏
tellraw @a {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}

# 劇情總文本
tellraw @a ["",{"text":"--------[","bold":true},{"text":"fire1 劇情總文本","color":"#A7A7A7"},{"text":"]--------","bold":true}]
tellraw @a {"translate":"story.fire.fire1.line1","with":[{"selector":"@e[tag=PlayerName]","color":"aqua"}]}
tellraw @a {"translate":"story.fire.fire1.line2","with":[{"selector":"@e[tag=PlayerName]","color":"aqua"}]}
tellraw @a {"translate":"story.fire.fire1.line3"}
tellraw @a {"translate":"story.fire.fire1.line4"}
tellraw @a {"translate":"story.fire.fire1.line5"}
tellraw @a {"translate":"story.fire.fire1.line6"}
tellraw @a {"translate":"story.fire.fire1.line7"}
tellraw @a {"translate":"story.fire.fire1.line8"}
tellraw @a {"translate":"story.fire.fire1.line9"}
tellraw @a {"translate":"story.fire.fire1.line10"}
tellraw @a {"translate":"story.fire.fire1.line11"}
tellraw @a {"translate":"story.fire.fire1.line12"}
tellraw @a {"translate":"story.fire.fire1.line13"}
tellraw @a {"translate":"story.fire.fire1.line14"}
tellraw @a {"translate":"story.fire.fire1.line15"}

# 直接執行清理（跳過所有特效）
function dialogtest:fire/fire1/cleanup
