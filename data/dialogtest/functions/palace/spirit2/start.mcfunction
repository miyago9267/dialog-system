

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.palace.spirit2.line1"},{t:40,type:"text",key:"story.palace.spirit2.line2"},{t:80,type:"text",key:"story.palace.spirit2.line3"},{t:120,type:"text",key:"story.palace.spirit2.line4"},{t:160,type:"text",key:"story.palace.spirit2.line5"},{t:200,type:"text",key:"story.palace.spirit2.line6"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:240,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "palace_spirit2"
data modify storage dialogtest:story run.scene_tick set value 0
