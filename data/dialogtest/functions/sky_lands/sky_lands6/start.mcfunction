# 設置已觸發，防止重複執行
scoreboard players set sky_lands6_triggered sky_lands_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.sky_lands.sky_lands6.line1"},{t:65,type:"text",key:"story.sky_lands.sky_lands6.line2"},{t:145,type:"text_player",key:"story.sky_lands.sky_lands6.line3"},{t:225,type:"text",key:"story.sky_lands.sky_lands6.line4"},{t:265,type:"text",key:"story.sky_lands.sky_lands6.line5"},{t:345,type:"text",key:"story.sky_lands.sky_lands6.line6"},{t:425,type:"text",key:"story.sky_lands.sky_lands6.line7"},{t:465,type:"text",key:"story.sky_lands.sky_lands6.line8"},{t:545,type:"text",key:"story.sky_lands.sky_lands6.line9"},{t:625,type:"text",key:"story.sky_lands.sky_lands6.line10"},{t:665,type:"text",key:"story.sky_lands.sky_lands6.line11"},{t:745,type:"text",key:"story.sky_lands.sky_lands6.line12"},{t:825,type:"text",key:"story.sky_lands.sky_lands6.line13"},{t:865,type:"text",key:"story.sky_lands.sky_lands6.line14"},{t:945,type:"text",key:"story.sky_lands.sky_lands6.line15"},{t:1025,type:"text",key:"story.sky_lands.sky_lands6.line16"},{t:1065,type:"text",key:"story.sky_lands.sky_lands6.line17"},{t:1145,type:"text",key:"story.sky_lands.sky_lands6.line18"},{t:1225,type:"text",key:"story.sky_lands.sky_lands6.line19"},{t:1265,type:"text_player",key:"story.sky_lands.sky_lands6.line20"},{t:1345,type:"text",key:"story.sky_lands.sky_lands6.line21"},{t:1425,type:"text",key:"story.sky_lands.sky_lands6.line22"},{t:1465,type:"text",key:"story.sky_lands.sky_lands6.line23"}]

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1525,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:1545,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "sky_lands_sky_lands6"
data modify storage dialogtest:story run.scene_tick set value 0
