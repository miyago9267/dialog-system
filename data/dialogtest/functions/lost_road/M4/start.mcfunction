# 設置已觸發，防止重複執行
scoreboard players set M4_triggered lost_road_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.lost_road.M4.line1"},{t:65,type:"text",key:"story.lost_road.M4.line2"},{t:145,type:"text",key:"story.lost_road.M4.line3"},{t:225,type:"text_player",key:"story.lost_road.M4.line4"},{t:265,type:"text",key:"story.lost_road.M4.line5"},{t:345,type:"text_player",key:"story.lost_road.M4.line6"},{t:425,type:"text",key:"story.lost_road.M4.line7"},{t:465,type:"text",key:"story.lost_road.M4.line8"},{t:545,type:"text_player",key:"story.lost_road.M4.line9"},{t:625,type:"text",key:"story.lost_road.M4.line10"},{t:665,type:"text",key:"story.lost_road.M4.line11"},{t:745,type:"text_player",key:"story.lost_road.M4.line12"},{t:825,type:"text",key:"story.lost_road.M4.line13"},{t:865,type:"text",key:"story.lost_road.M4.line14"},{t:945,type:"text",key:"story.lost_road.M4.line15"},{t:1025,type:"text",key:"story.lost_road.M4.line16"},{t:1065,type:"text",key:"story.lost_road.M4.line17"},{t:1145,type:"text",key:"story.lost_road.M4.line18"},{t:1225,type:"text",key:"story.lost_road.M4.line19"},{t:1265,type:"text",key:"story.lost_road.M4.line20"},{t:1345,type:"text",key:"story.lost_road.M4.line21"},{t:1425,type:"text",key:"story.lost_road.M4.line22"},{t:1465,type:"text",key:"story.lost_road.M4.line23"},{t:1545,type:"text",key:"story.lost_road.M4.line24"},{t:1625,type:"text",key:"story.lost_road.M4.line25"},{t:1665,type:"text",key:"story.lost_road.M4.line26"},{t:1745,type:"text",key:"story.lost_road.M4.line27"},{t:1825,type:"text",key:"story.lost_road.M4.line28"},{t:1865,type:"text",key:"story.lost_road.M4.line29"},{t:1945,type:"text",key:"story.lost_road.M4.line30"},{t:2025,type:"text",key:"story.lost_road.M4.line31"},{t:2065,type:"text",key:"story.lost_road.M4.line32"},{t:2145,type:"text",key:"story.lost_road.M4.line33"},{t:2225,type:"text",key:"story.lost_road.M4.line34"},{t:2265,type:"text",key:"story.lost_road.M4.line35"},{t:2345,type:"text",key:"story.lost_road.M4.line36"},{t:2425,type:"text",key:"story.lost_road.M4.line37"},{t:2465,type:"text",key:"story.lost_road.M4.line38"},{t:2545,type:"text",key:"story.lost_road.M4.line39"},{t:2625,type:"text",key:"story.lost_road.M4.line40"},{t:2665,type:"text",key:"story.lost_road.M4.line41"},{t:2745,type:"text",key:"story.lost_road.M4.line42"},{t:2825,type:"text",key:"story.lost_road.M4.line43"},{t:2865,type:"text",key:"story.lost_road.M4.line44"},{t:2945,type:"text",key:"story.lost_road.M4.line45"},{t:3025,type:"text",key:"story.lost_road.M4.line46"},{t:3065,type:"text",key:"story.lost_road.M4.line47"},{t:3145,type:"text",key:"story.lost_road.M4.line48"},{t:3225,type:"text",key:"story.lost_road.M4.line49"}]

# [DISABLED] action 軌（動作事件，每個指向 stub mcfunction）
# data modify storage dialogtest:story run.action set value [{t:105,type:"fn",fn:"dialogtest:lost_road/M4/act1"},{t:545,type:"fn",fn:"dialogtest:lost_road/M4/act2"}]
# act1 (t=80, line3): 從看尤尼恩轉過頭看主角
# act2 (t=520, line14): 莎琳瑟芬離開了

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:3245,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:3265,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "lost_road_M4"
data modify storage dialogtest:story run.scene_tick set value 0
