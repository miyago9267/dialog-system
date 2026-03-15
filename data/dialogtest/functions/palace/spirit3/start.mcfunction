

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.palace.spirit3.line1"},{t:65,type:"text",key:"story.palace.spirit3.line2"},{t:105,type:"text",key:"story.palace.spirit3.line3"},{t:145,type:"text",key:"story.palace.spirit3.line4"},{t:185,type:"text",key:"story.palace.spirit3.line5"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:205,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:225,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "palace_spirit3"
data modify storage dialogtest:story run.scene_tick set value 0
