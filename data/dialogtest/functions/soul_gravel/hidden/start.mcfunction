

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.soul_gravel.hidden.line1"},{t:65,type:"text",key:"story.soul_gravel.hidden.line2"},{t:145,type:"text",key:"story.soul_gravel.hidden.line3"},{t:225,type:"text",key:"story.soul_gravel.hidden.line4"},{t:265,type:"text",key:"story.soul_gravel.hidden.line5"},{t:345,type:"text",key:"story.soul_gravel.hidden.line6"},{t:425,type:"text",key:"story.soul_gravel.hidden.line7"},{t:465,type:"text",key:"story.soul_gravel.hidden.line8"},{t:545,type:"text",key:"story.soul_gravel.hidden.line9"},{t:625,type:"text",key:"story.soul_gravel.hidden.line10"},{t:665,type:"text",key:"story.soul_gravel.hidden.line11"},{t:745,type:"text",key:"story.soul_gravel.hidden.line12"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:765,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:825,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "soul_gravel_hidden"
data modify storage dialogtest:story run.scene_tick set value 0
