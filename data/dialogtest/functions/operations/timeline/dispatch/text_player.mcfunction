# 帶玩家名稱的台詞（macro）
# 事件格式：{t: N, type: "text_player", key: "story.chapter.para.lineN"}
$tellraw @a {"translate":"$(key)","with":[{"selector":"@e[tag=PlayerName]","color":"aqua"}]}
