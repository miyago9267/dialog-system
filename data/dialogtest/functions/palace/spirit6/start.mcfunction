

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.palace.spirit6.line1"},{t:65,type:"text",key:"story.palace.spirit6.line2"},{t:125,type:"text",key:"story.palace.spirit6.line3"},{t:185,type:"text",key:"story.palace.spirit6.line4"},{t:225,type:"text",key:"story.palace.spirit6.line5"},{t:285,type:"text",key:"story.palace.spirit6.line6"},{t:345,type:"text",key:"story.palace.spirit6.line7"},{t:385,type:"text",key:"story.palace.spirit6.line8"},{t:445,type:"text",key:"story.palace.spirit6.line9"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:465,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:505,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "palace_spirit6"
data modify storage dialogtest:story run.scene_tick set value 0
