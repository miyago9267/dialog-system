# 遞迴輸出 run.text 軌道中所有剩餘的台詞
# 用於跳過劇情時一次顯示全部文本

execute unless data storage dialogtest:story run.text[0] run return 0

# 取出第一個事件到 current_event
data modify storage dialogtest:story run.current_event set from storage dialogtest:story run.text[0]
data remove storage dialogtest:story run.text[0]

# 派發（執行 tellraw）
function dialogtest:operations/timeline/dispatch_event

# 遞迴處理剩餘事件
function dialogtest:operations/timeline/flush_text
