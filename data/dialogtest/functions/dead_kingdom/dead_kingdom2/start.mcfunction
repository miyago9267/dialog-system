# 設置已觸發，防止重複執行
scoreboard players set dead_kingdom2_triggered dead_kingdom_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.dead_kingdom.dead_kingdom2.line1"},{t:65,type:"text",key:"story.dead_kingdom.dead_kingdom2.line2"},{t:125,type:"text",key:"story.dead_kingdom.dead_kingdom2.line3"},{t:185,type:"text",key:"story.dead_kingdom.dead_kingdom2.line4"},{t:225,type:"text",key:"story.dead_kingdom.dead_kingdom2.line5"},{t:285,type:"text",key:"story.dead_kingdom.dead_kingdom2.line6"},{t:345,type:"text",key:"story.dead_kingdom.dead_kingdom2.line7"},{t:385,type:"text_player",key:"story.dead_kingdom.dead_kingdom2.line8"},{t:445,type:"text",key:"story.dead_kingdom.dead_kingdom2.line9"},{t:505,type:"text",key:"story.dead_kingdom.dead_kingdom2.line10"},{t:545,type:"text",key:"story.dead_kingdom.dead_kingdom2.line11"},{t:605,type:"text",key:"story.dead_kingdom.dead_kingdom2.line12"},{t:665,type:"text",key:"story.dead_kingdom.dead_kingdom2.line13"},{t:705,type:"text",key:"story.dead_kingdom.dead_kingdom2.line14"},{t:765,type:"text",key:"story.dead_kingdom.dead_kingdom2.line15"},{t:825,type:"text",key:"story.dead_kingdom.dead_kingdom2.line16"},{t:865,type:"text",key:"story.dead_kingdom.dead_kingdom2.line17"},{t:925,type:"text",key:"story.dead_kingdom.dead_kingdom2.line18"},{t:985,type:"text",key:"story.dead_kingdom.dead_kingdom2.line19"},{t:1025,type:"text",key:"story.dead_kingdom.dead_kingdom2.line20"},{t:1085,type:"text",key:"story.dead_kingdom.dead_kingdom2.line21"},{t:1145,type:"text",key:"story.dead_kingdom.dead_kingdom2.line22"},{t:1185,type:"text",key:"story.dead_kingdom.dead_kingdom2.line23"},{t:1245,type:"text",key:"story.dead_kingdom.dead_kingdom2.line24"},{t:1305,type:"text",key:"story.dead_kingdom.dead_kingdom2.line25"},{t:1345,type:"text",key:"story.dead_kingdom.dead_kingdom2.line26"},{t:1405,type:"text",key:"story.dead_kingdom.dead_kingdom2.line27"}]

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1425,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:1465,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "dead_kingdom_dead_kingdom2"
data modify storage dialogtest:story run.scene_tick set value 0
