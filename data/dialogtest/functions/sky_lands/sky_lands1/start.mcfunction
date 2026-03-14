# 設置已觸發，防止重複執行
scoreboard players set sky_lands1_triggered sky_lands_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.sky_lands.sky_lands1.line1"},{t:40,type:"text",key:"story.sky_lands.sky_lands1.line2"},{t:80,type:"text",key:"story.sky_lands.sky_lands1.line3"},{t:120,type:"text",key:"story.sky_lands.sky_lands1.line4"},{t:160,type:"text",key:"story.sky_lands.sky_lands1.line5"},{t:200,type:"text",key:"story.sky_lands.sky_lands1.line6"},{t:240,type:"text",key:"story.sky_lands.sky_lands1.line7"},{t:280,type:"text_player",key:"story.sky_lands.sky_lands1.line8"},{t:320,type:"text_player",key:"story.sky_lands.sky_lands1.line9"},{t:360,type:"text",key:"story.sky_lands.sky_lands1.line10"},{t:400,type:"text",key:"story.sky_lands.sky_lands1.line11"},{t:440,type:"text",key:"story.sky_lands.sky_lands1.line12"},{t:480,type:"text",key:"story.sky_lands.sky_lands1.line13"},{t:520,type:"text",key:"story.sky_lands.sky_lands1.line14"},{t:560,type:"text",key:"story.sky_lands.sky_lands1.line15"},{t:600,type:"text",key:"story.sky_lands.sky_lands1.line16"},{t:640,type:"text",key:"story.sky_lands.sky_lands1.line17"},{t:680,type:"text",key:"story.sky_lands.sky_lands1.line18"},{t:720,type:"text",key:"story.sky_lands.sky_lands1.line19"},{t:760,type:"text",key:"story.sky_lands.sky_lands1.line20"},{t:800,type:"text",key:"story.sky_lands.sky_lands1.line21"},{t:840,type:"text",key:"story.sky_lands.sky_lands1.line22"},{t:880,type:"text",key:"story.sky_lands.sky_lands1.line23"},{t:920,type:"text",key:"story.sky_lands.sky_lands1.line24"},{t:960,type:"text",key:"story.sky_lands.sky_lands1.line25"},{t:1000,type:"text",key:"story.sky_lands.sky_lands1.line26"},{t:1040,type:"text",key:"story.sky_lands.sky_lands1.line27"},{t:1080,type:"text",key:"story.sky_lands.sky_lands1.line28"},{t:1120,type:"text",key:"story.sky_lands.sky_lands1.line29"},{t:1160,type:"text",key:"story.sky_lands.sky_lands1.line30"},{t:1200,type:"text",key:"story.sky_lands.sky_lands1.line31"},{t:1240,type:"text",key:"story.sky_lands.sky_lands1.line32"},{t:1280,type:"text",key:"story.sky_lands.sky_lands1.line33"},{t:1320,type:"text",key:"story.sky_lands.sky_lands1.line34"},{t:1360,type:"text",key:"story.sky_lands.sky_lands1.line35"},{t:1400,type:"text",key:"story.sky_lands.sky_lands1.line36"},{t:1440,type:"text",key:"story.sky_lands.sky_lands1.line37"},{t:1480,type:"text",key:"story.sky_lands.sky_lands1.line38"},{t:1520,type:"text",key:"story.sky_lands.sky_lands1.line39"},{t:1560,type:"text",key:"story.sky_lands.sky_lands1.line40"}]

# [DISABLED] action 軌（動作事件，每個指向 stub mcfunction）
# data modify storage dialogtest:story run.action set value [{t:0,type:"fn",fn:"dialogtest:sky_lands/sky_lands1/act1"}]
# act1 (t=0, line1): 特殊冒險系統，雲朵粒子，藉由投擲物刺激雲朵粒子能夠使雲朵粒子變成雲朵，讓玩家能夠在雲朵上移動

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1600,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "sky_lands_sky_lands1"
data modify storage dialogtest:story run.scene_tick set value 0
