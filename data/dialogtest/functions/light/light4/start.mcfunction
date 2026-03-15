# 設置已觸發，防止重複執行
scoreboard players set light4_triggered light_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.light.light4.line1"},{t:65,type:"text",key:"story.light.light4.line2"},{t:145,type:"text",key:"story.light.light4.line3"},{t:225,type:"text",key:"story.light.light4.line4"},{t:265,type:"text",key:"story.light.light4.line5"},{t:345,type:"text",key:"story.light.light4.line6"},{t:425,type:"text",key:"story.light.light4.line7"},{t:465,type:"text",key:"story.light.light4.line8"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:525,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:545,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "light_light4"
data modify storage dialogtest:story run.scene_tick set value 0
