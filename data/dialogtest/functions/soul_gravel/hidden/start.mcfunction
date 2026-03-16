

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.soul_gravel.hidden.line1"},{t:65,type:"text",key:"story.soul_gravel.hidden.line2"},{t:125,type:"text",key:"story.soul_gravel.hidden.line3"},{t:185,type:"text",key:"story.soul_gravel.hidden.line4"},{t:225,type:"text",key:"story.soul_gravel.hidden.line5"},{t:285,type:"text",key:"story.soul_gravel.hidden.line6"},{t:345,type:"text",key:"story.soul_gravel.hidden.line7"},{t:385,type:"text",key:"story.soul_gravel.hidden.line8"},{t:445,type:"text",key:"story.soul_gravel.hidden.line9"},{t:505,type:"text",key:"story.soul_gravel.hidden.line10"},{t:545,type:"text",key:"story.soul_gravel.hidden.line11"},{t:605,type:"text",key:"story.soul_gravel.hidden.line12"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:625,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:665,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "soul_gravel_hidden"
data modify storage dialogtest:story run.scene_tick set value 0
