

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.village.migale.line1"},{t:40,type:"text",key:"story.village.migale.line2"},{t:80,type:"text",key:"story.village.migale.line3"},{t:120,type:"text",key:"story.village.migale.line4"},{t:160,type:"text",key:"story.village.migale.line5"},{t:200,type:"text",key:"story.village.migale.line6"},{t:240,type:"text",key:"story.village.migale.line7"},{t:280,type:"text",key:"story.village.migale.line8"},{t:320,type:"text",key:"story.village.migale.line9"},{t:360,type:"text",key:"story.village.migale.line10"},{t:400,type:"text",key:"story.village.migale.line11"},{t:440,type:"text",key:"story.village.migale.line12"},{t:480,type:"text_player",key:"story.village.migale.line13"},{t:520,type:"text",key:"story.village.migale.line14"},{t:560,type:"text",key:"story.village.migale.line15"},{t:600,type:"text",key:"story.village.migale.line16"},{t:640,type:"text",key:"story.village.migale.line17"},{t:680,type:"text",key:"story.village.migale.line18"},{t:720,type:"text",key:"story.village.migale.line19"},{t:760,type:"text",key:"story.village.migale.line20"},{t:800,type:"text",key:"story.village.migale.line21"},{t:840,type:"text",key:"story.village.migale.line22"},{t:880,type:"text",key:"story.village.migale.line23"},{t:920,type:"text",key:"story.village.migale.line24"},{t:960,type:"text",key:"story.village.migale.line25"},{t:1000,type:"text",key:"story.village.migale.line26"},{t:1040,type:"text",key:"story.village.migale.line27"},{t:1080,type:"text_player",key:"story.village.migale.line28"},{t:1120,type:"text",key:"story.village.migale.line29"},{t:1160,type:"text",key:"story.village.migale.line30"},{t:1200,type:"text",key:"story.village.migale.line31"},{t:1240,type:"text",key:"story.village.migale.line32"},{t:1280,type:"text",key:"story.village.migale.line33"},{t:1320,type:"text",key:"story.village.migale.line34"},{t:1360,type:"text",key:"story.village.migale.line35"},{t:1400,type:"text",key:"story.village.migale.line36"},{t:1440,type:"text",key:"story.village.migale.line37"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1480,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "village_migale"
data modify storage dialogtest:story run.scene_tick set value 0
