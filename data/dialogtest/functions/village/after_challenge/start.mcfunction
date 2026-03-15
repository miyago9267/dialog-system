

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.village.after_challenge.line1"},{t:65,type:"text",key:"story.village.after_challenge.line2"},{t:105,type:"text",key:"story.village.after_challenge.line3"},{t:145,type:"text",key:"story.village.after_challenge.line4"},{t:185,type:"text",key:"story.village.after_challenge.line5"},{t:225,type:"text",key:"story.village.after_challenge.line6"},{t:265,type:"text",key:"story.village.after_challenge.line7"},{t:305,type:"text",key:"story.village.after_challenge.line8"},{t:345,type:"text",key:"story.village.after_challenge.line9"},{t:385,type:"text",key:"story.village.after_challenge.line10"},{t:425,type:"text",key:"story.village.after_challenge.line11"},{t:465,type:"text",key:"story.village.after_challenge.line12"},{t:505,type:"text",key:"story.village.after_challenge.line13"},{t:545,type:"text",key:"story.village.after_challenge.line14"},{t:585,type:"text",key:"story.village.after_challenge.line15"},{t:625,type:"text",key:"story.village.after_challenge.line16"},{t:665,type:"text",key:"story.village.after_challenge.line17"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:685,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:705,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "village_after_challenge"
data modify storage dialogtest:story run.scene_tick set value 0
