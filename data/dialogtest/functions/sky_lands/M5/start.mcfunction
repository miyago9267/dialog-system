# 設置已觸發，防止重複執行
scoreboard players set M5_triggered sky_lands_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.sky_lands.M5.line1"},{t:65,type:"text",key:"story.sky_lands.M5.line2"},{t:105,type:"text",key:"story.sky_lands.M5.line3"},{t:145,type:"text",key:"story.sky_lands.M5.line4"},{t:185,type:"text",key:"story.sky_lands.M5.line5"},{t:225,type:"text",key:"story.sky_lands.M5.line6"},{t:265,type:"text",key:"story.sky_lands.M5.line7"},{t:305,type:"text",key:"story.sky_lands.M5.line8"},{t:345,type:"text",key:"story.sky_lands.M5.line9"},{t:385,type:"text",key:"story.sky_lands.M5.line10"},{t:425,type:"text",key:"story.sky_lands.M5.line11"},{t:465,type:"text",key:"story.sky_lands.M5.line12"},{t:505,type:"text",key:"story.sky_lands.M5.line13"},{t:545,type:"text",key:"story.sky_lands.M5.line14"},{t:585,type:"text",key:"story.sky_lands.M5.line15"},{t:625,type:"text",key:"story.sky_lands.M5.line16"},{t:665,type:"text",key:"story.sky_lands.M5.line17"},{t:705,type:"text",key:"story.sky_lands.M5.line18"},{t:745,type:"text",key:"story.sky_lands.M5.line19"},{t:785,type:"text",key:"story.sky_lands.M5.line20"},{t:825,type:"text",key:"story.sky_lands.M5.line21"},{t:865,type:"text",key:"story.sky_lands.M5.line22"},{t:905,type:"text",key:"story.sky_lands.M5.line23"},{t:945,type:"text",key:"story.sky_lands.M5.line24"},{t:985,type:"text",key:"story.sky_lands.M5.line25"},{t:1025,type:"text",key:"story.sky_lands.M5.line26"},{t:1065,type:"text",key:"story.sky_lands.M5.line27"},{t:1105,type:"text",key:"story.sky_lands.M5.line28"},{t:1145,type:"text",key:"story.sky_lands.M5.line29"},{t:1185,type:"text",key:"story.sky_lands.M5.line30"},{t:1225,type:"text",key:"story.sky_lands.M5.line31"},{t:1265,type:"text",key:"story.sky_lands.M5.line32"},{t:1305,type:"text",key:"story.sky_lands.M5.line33"},{t:1345,type:"text",key:"story.sky_lands.M5.line34"},{t:1385,type:"text",key:"story.sky_lands.M5.line35"},{t:1425,type:"text",key:"story.sky_lands.M5.line36"},{t:1465,type:"text",key:"story.sky_lands.M5.line37"},{t:1505,type:"text",key:"story.sky_lands.M5.line38"},{t:1545,type:"text",key:"story.sky_lands.M5.line39"},{t:1585,type:"text",key:"story.sky_lands.M5.line40"},{t:1625,type:"text",key:"story.sky_lands.M5.line41"},{t:1665,type:"text",key:"story.sky_lands.M5.line42"},{t:1705,type:"text",key:"story.sky_lands.M5.line43"},{t:1745,type:"text",key:"story.sky_lands.M5.line44"},{t:1785,type:"text",key:"story.sky_lands.M5.line45"},{t:1825,type:"text",key:"story.sky_lands.M5.line46"}]

# [DISABLED] action 軌（動作事件，每個指向 stub mcfunction）
# data modify storage dialogtest:story run.action set value [{t:745,type:"fn",fn:"dialogtest:sky_lands/M5/act1"},{t:825,type:"fn",fn:"dialogtest:sky_lands/M5/act2"},{t:945,type:"fn",fn:"dialogtest:sky_lands/M5/act3"}]
# act1 (t=720, line19): 黑畫面標題文字
# act2 (t=800, line21): 黑畫面標題文字
# act3 (t=920, line24): 黑畫面標題文字

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1845,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:1865,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "sky_lands_M5"
data modify storage dialogtest:story run.scene_tick set value 0
