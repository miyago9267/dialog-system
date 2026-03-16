# 設置已觸發，防止重複執行
scoreboard players set 4_triggered sky_palace_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.sky_palace.4.line1"},{t:65,type:"text_player",key:"story.sky_palace.4.line2"},{t:125,type:"text_player",key:"story.sky_palace.4.line3"},{t:185,type:"text",key:"story.sky_palace.4.line4"},{t:225,type:"text",key:"story.sky_palace.4.line5"},{t:285,type:"text",key:"story.sky_palace.4.line6"}]

# [DISABLED] action 軌（動作事件，每個指向 stub mcfunction）
# data modify storage dialogtest:story run.action set value [{t:25,type:"fn",fn:"dialogtest:sky_palace/4/act1"}]
# act1 (t=0, line1): 1.點頭
# 2.搖頭
# 3.走路
# 4.撥開
# 5.原地跳躍
# 6.向前跳
# 7.伸手
# 8.揮手
# 9.歪頭
10.

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:305,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:345,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "sky_palace_4"
data modify storage dialogtest:story run.scene_tick set value 0
