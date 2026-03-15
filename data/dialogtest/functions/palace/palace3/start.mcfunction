# 設置已觸發，防止重複執行
scoreboard players set palace3_triggered palace_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.palace.palace3.line1"},{t:65,type:"text",key:"story.palace.palace3.line2"},{t:105,type:"text",key:"story.palace.palace3.line3"},{t:145,type:"text",key:"story.palace.palace3.line4"},{t:185,type:"text",key:"story.palace.palace3.line5"},{t:225,type:"text_player",key:"story.palace.palace3.line6"},{t:265,type:"text",key:"story.palace.palace3.line7"},{t:305,type:"text",key:"story.palace.palace3.line8"},{t:345,type:"text",key:"story.palace.palace3.line9"},{t:385,type:"text",key:"story.palace.palace3.line10"},{t:425,type:"text",key:"story.palace.palace3.line11"},{t:465,type:"text",key:"story.palace.palace3.line12"},{t:505,type:"text_player",key:"story.palace.palace3.line13"},{t:545,type:"text",key:"story.palace.palace3.line14"},{t:585,type:"text",key:"story.palace.palace3.line15"},{t:625,type:"text",key:"story.palace.palace3.line16"},{t:665,type:"text",key:"story.palace.palace3.line17"},{t:705,type:"text",key:"story.palace.palace3.line18"},{t:745,type:"text_player",key:"story.palace.palace3.line19"},{t:785,type:"text",key:"story.palace.palace3.line20"},{t:825,type:"text",key:"story.palace.palace3.line21"},{t:865,type:"text",key:"story.palace.palace3.line22"},{t:905,type:"text",key:"story.palace.palace3.line23"},{t:945,type:"text",key:"story.palace.palace3.line24"},{t:985,type:"text",key:"story.palace.palace3.line25"},{t:1025,type:"text",key:"story.palace.palace3.line26"},{t:1065,type:"text",key:"story.palace.palace3.line27"},{t:1105,type:"text",key:"story.palace.palace3.line28"},{t:1145,type:"text",key:"story.palace.palace3.line29"},{t:1185,type:"text",key:"story.palace.palace3.line30"},{t:1225,type:"text",key:"story.palace.palace3.line31"},{t:1265,type:"text",key:"story.palace.palace3.line32"},{t:1305,type:"text",key:"story.palace.palace3.line33"},{t:1345,type:"text",key:"story.palace.palace3.line34"},{t:1385,type:"text",key:"story.palace.palace3.line35"},{t:1425,type:"text",key:"story.palace.palace3.line36"}]

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1445,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:1465,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "palace_palace3"
data modify storage dialogtest:story run.scene_tick set value 0
