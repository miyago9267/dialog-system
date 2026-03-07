

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.tower.tower3.line1"},{t:40,type:"text",key:"story.tower.tower3.line2"},{t:80,type:"text",key:"story.tower.tower3.line3"},{t:120,type:"text",key:"story.tower.tower3.line4"},{t:160,type:"text",key:"story.tower.tower3.line5"},{t:200,type:"text",key:"story.tower.tower3.line6"},{t:240,type:"text",key:"story.tower.tower3.line7"},{t:280,type:"text",key:"story.tower.tower3.line8"},{t:320,type:"text",key:"story.tower.tower3.line9"},{t:360,type:"text",key:"story.tower.tower3.line10"},{t:400,type:"text",key:"story.tower.tower3.line11"},{t:440,type:"text",key:"story.tower.tower3.line12"},{t:480,type:"text",key:"story.tower.tower3.line13"},{t:520,type:"text",key:"story.tower.tower3.line14"},{t:560,type:"text",key:"story.tower.tower3.line15"},{t:600,type:"text",key:"story.tower.tower3.line16"},{t:640,type:"text",key:"story.tower.tower3.line17"},{t:680,type:"text",key:"story.tower.tower3.line18"},{t:720,type:"text",key:"story.tower.tower3.line19"},{t:760,type:"text",key:"story.tower.tower3.line20"},{t:800,type:"text",key:"story.tower.tower3.line21"},{t:840,type:"text",key:"story.tower.tower3.line22"},{t:880,type:"text",key:"story.tower.tower3.line23"},{t:920,type:"text",key:"story.tower.tower3.line24"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:960,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "tower_tower3"
data modify storage dialogtest:story run.scene_tick set value 0
