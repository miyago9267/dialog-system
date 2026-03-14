# 設置已觸發，防止重複執行
scoreboard players set M4_triggered lost_road_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.lost_road.M4.line1"},{t:40,type:"text",key:"story.lost_road.M4.line2"},{t:80,type:"text",key:"story.lost_road.M4.line3"},{t:120,type:"text_player",key:"story.lost_road.M4.line4"},{t:160,type:"text",key:"story.lost_road.M4.line5"},{t:200,type:"text_player",key:"story.lost_road.M4.line6"},{t:240,type:"text",key:"story.lost_road.M4.line7"},{t:280,type:"text",key:"story.lost_road.M4.line8"},{t:320,type:"text_player",key:"story.lost_road.M4.line9"},{t:360,type:"text",key:"story.lost_road.M4.line10"},{t:400,type:"text",key:"story.lost_road.M4.line11"},{t:440,type:"text_player",key:"story.lost_road.M4.line12"},{t:480,type:"text",key:"story.lost_road.M4.line13"},{t:520,type:"text",key:"story.lost_road.M4.line14"},{t:560,type:"text",key:"story.lost_road.M4.line15"},{t:600,type:"text",key:"story.lost_road.M4.line16"},{t:640,type:"text",key:"story.lost_road.M4.line17"},{t:680,type:"text",key:"story.lost_road.M4.line18"},{t:720,type:"text",key:"story.lost_road.M4.line19"},{t:760,type:"text",key:"story.lost_road.M4.line20"},{t:800,type:"text",key:"story.lost_road.M4.line21"},{t:840,type:"text",key:"story.lost_road.M4.line22"},{t:880,type:"text",key:"story.lost_road.M4.line23"},{t:920,type:"text",key:"story.lost_road.M4.line24"},{t:960,type:"text",key:"story.lost_road.M4.line25"},{t:1000,type:"text",key:"story.lost_road.M4.line26"},{t:1040,type:"text",key:"story.lost_road.M4.line27"},{t:1080,type:"text",key:"story.lost_road.M4.line28"},{t:1120,type:"text",key:"story.lost_road.M4.line29"},{t:1160,type:"text",key:"story.lost_road.M4.line30"},{t:1200,type:"text",key:"story.lost_road.M4.line31"},{t:1240,type:"text",key:"story.lost_road.M4.line32"},{t:1280,type:"text",key:"story.lost_road.M4.line33"},{t:1320,type:"text",key:"story.lost_road.M4.line34"},{t:1360,type:"text",key:"story.lost_road.M4.line35"},{t:1400,type:"text",key:"story.lost_road.M4.line36"},{t:1440,type:"text",key:"story.lost_road.M4.line37"},{t:1480,type:"text",key:"story.lost_road.M4.line38"},{t:1520,type:"text",key:"story.lost_road.M4.line39"},{t:1560,type:"text",key:"story.lost_road.M4.line40"},{t:1600,type:"text",key:"story.lost_road.M4.line41"},{t:1640,type:"text",key:"story.lost_road.M4.line42"},{t:1680,type:"text",key:"story.lost_road.M4.line43"},{t:1720,type:"text",key:"story.lost_road.M4.line44"},{t:1760,type:"text",key:"story.lost_road.M4.line45"},{t:1800,type:"text",key:"story.lost_road.M4.line46"},{t:1840,type:"text",key:"story.lost_road.M4.line47"},{t:1880,type:"text",key:"story.lost_road.M4.line48"},{t:1920,type:"text",key:"story.lost_road.M4.line49"}]

# [DISABLED] action 軌（動作事件，每個指向 stub mcfunction）
# data modify storage dialogtest:story run.action set value [{t:80,type:"fn",fn:"dialogtest:lost_road/M4/act1"},{t:520,type:"fn",fn:"dialogtest:lost_road/M4/act2"}]
# act1 (t=80, line3): 從看尤尼恩轉過頭看主角
# act2 (t=520, line14): 莎琳瑟芬離開了

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1960,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "lost_road_M4"
data modify storage dialogtest:story run.scene_tick set value 0
