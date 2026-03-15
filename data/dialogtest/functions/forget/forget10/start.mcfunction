

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.forget.forget10.line1"},{t:65,type:"text",key:"story.forget.forget10.line2"},{t:145,type:"text",key:"story.forget.forget10.line3"},{t:225,type:"text_player",key:"story.forget.forget10.line4"},{t:265,type:"text",key:"story.forget.forget10.line5"},{t:345,type:"text_player",key:"story.forget.forget10.line6"},{t:425,type:"text",key:"story.forget.forget10.line7"},{t:465,type:"text",key:"story.forget.forget10.line8"},{t:545,type:"text",key:"story.forget.forget10.line9"},{t:625,type:"text",key:"story.forget.forget10.line10"},{t:665,type:"text",key:"story.forget.forget10.line11"},{t:745,type:"text",key:"story.forget.forget10.line12"},{t:825,type:"text",key:"story.forget.forget10.line13"},{t:865,type:"text",key:"story.forget.forget10.line14"},{t:945,type:"text",key:"story.forget.forget10.line15"},{t:1025,type:"text",key:"story.forget.forget10.line16"},{t:1065,type:"text",key:"story.forget.forget10.line17"},{t:1145,type:"text",key:"story.forget.forget10.line18"},{t:1225,type:"text",key:"story.forget.forget10.line19"},{t:1265,type:"text",key:"story.forget.forget10.line20"},{t:1345,type:"text",key:"story.forget.forget10.line21"},{t:1425,type:"text",key:"story.forget.forget10.line22"},{t:1465,type:"text",key:"story.forget.forget10.line23"},{t:1545,type:"text",key:"story.forget.forget10.line24"},{t:1625,type:"text",key:"story.forget.forget10.line25"},{t:1665,type:"text",key:"story.forget.forget10.line26"},{t:1745,type:"text",key:"story.forget.forget10.line27"},{t:1825,type:"text",key:"story.forget.forget10.line28"},{t:1865,type:"text",key:"story.forget.forget10.line29"},{t:1945,type:"text",key:"story.forget.forget10.line30"},{t:2025,type:"text",key:"story.forget.forget10.line31"},{t:2065,type:"text",key:"story.forget.forget10.line32"},{t:2145,type:"text",key:"story.forget.forget10.line33"},{t:2225,type:"text",key:"story.forget.forget10.line34"},{t:2265,type:"text",key:"story.forget.forget10.line35"},{t:2345,type:"text",key:"story.forget.forget10.line36"},{t:2425,type:"text",key:"story.forget.forget10.line37"},{t:2465,type:"text",key:"story.forget.forget10.line38"},{t:2545,type:"text",key:"story.forget.forget10.line39"},{t:2625,type:"text",key:"story.forget.forget10.line40"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:2645,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:2665,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "forget_forget10"
data modify storage dialogtest:story run.scene_tick set value 0
