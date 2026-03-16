

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.village.migale.line1"},{t:65,type:"text",key:"story.village.migale.line2"},{t:125,type:"text",key:"story.village.migale.line3"},{t:185,type:"text",key:"story.village.migale.line4"},{t:225,type:"text",key:"story.village.migale.line5"},{t:285,type:"text",key:"story.village.migale.line6"},{t:345,type:"text",key:"story.village.migale.line7"},{t:385,type:"text",key:"story.village.migale.line8"},{t:445,type:"text",key:"story.village.migale.line9"},{t:505,type:"text",key:"story.village.migale.line10"},{t:545,type:"text",key:"story.village.migale.line11"},{t:605,type:"text",key:"story.village.migale.line12"},{t:665,type:"text_player",key:"story.village.migale.line13"},{t:705,type:"text",key:"story.village.migale.line14"},{t:765,type:"text",key:"story.village.migale.line15"},{t:825,type:"text",key:"story.village.migale.line16"},{t:865,type:"text",key:"story.village.migale.line17"},{t:925,type:"text",key:"story.village.migale.line18"},{t:985,type:"text",key:"story.village.migale.line19"},{t:1025,type:"text",key:"story.village.migale.line20"},{t:1085,type:"text",key:"story.village.migale.line21"},{t:1145,type:"text",key:"story.village.migale.line22"},{t:1185,type:"text",key:"story.village.migale.line23"},{t:1245,type:"text",key:"story.village.migale.line24"},{t:1305,type:"text",key:"story.village.migale.line25"},{t:1345,type:"text",key:"story.village.migale.line26"},{t:1405,type:"text",key:"story.village.migale.line27"},{t:1465,type:"text_player",key:"story.village.migale.line28"},{t:1505,type:"text",key:"story.village.migale.line29"},{t:1565,type:"text",key:"story.village.migale.line30"},{t:1625,type:"text",key:"story.village.migale.line31"},{t:1665,type:"text",key:"story.village.migale.line32"},{t:1725,type:"text",key:"story.village.migale.line33"},{t:1785,type:"text",key:"story.village.migale.line34"},{t:1825,type:"text",key:"story.village.migale.line35"},{t:1885,type:"text",key:"story.village.migale.line36"},{t:1945,type:"text",key:"story.village.migale.line37"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1965,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:1985,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "village_migale"
data modify storage dialogtest:story run.scene_tick set value 0
