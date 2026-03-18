# grass4 跳過劇情
# 一次吐出所有對話文本，然後直接清理

# 清屏
tellraw @a {"text":"\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n"}

# 劇情總文本
tellraw @a ["",{"text":"--------[","bold":true},{"text":"grass4 劇情總文本","color":"#A7A7A7"},{"text":"]--------","bold":true}]
tellraw @a {"translate":"story.grass.grass4.line1"}
tellraw @a {"translate":"story.grass.grass4.line2"}
tellraw @a {"translate":"story.grass.grass4.line3"}
tellraw @a {"translate":"story.grass.grass4.line4"}
tellraw @a {"translate":"story.grass.grass4.line5"}
tellraw @a {"translate":"story.grass.grass4.line6"}
tellraw @a {"translate":"story.grass.grass4.line7"}
tellraw @a {"translate":"story.grass.grass4.line8"}

# 直接執行清理（跳過所有特效）
function dialogtest:grass/grass4/cleanup
