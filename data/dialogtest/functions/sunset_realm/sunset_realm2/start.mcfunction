# 設置已觸發，防止重複執行
scoreboard players set sunset_realm2_triggered sunset_realm_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.sunset_realm.sunset_realm2.line1"},{t:65,type:"text",key:"story.sunset_realm.sunset_realm2.line2"},{t:105,type:"text",key:"story.sunset_realm.sunset_realm2.line3"},{t:145,type:"text",key:"story.sunset_realm.sunset_realm2.line4"},{t:185,type:"text",key:"story.sunset_realm.sunset_realm2.line5"},{t:225,type:"text",key:"story.sunset_realm.sunset_realm2.line6"},{t:265,type:"text",key:"story.sunset_realm.sunset_realm2.line7"},{t:305,type:"text",key:"story.sunset_realm.sunset_realm2.line8"},{t:345,type:"text_player",key:"story.sunset_realm.sunset_realm2.line9"},{t:385,type:"text",key:"story.sunset_realm.sunset_realm2.line10"},{t:425,type:"text",key:"story.sunset_realm.sunset_realm2.line11"},{t:465,type:"text",key:"story.sunset_realm.sunset_realm2.line12"},{t:505,type:"text_player",key:"story.sunset_realm.sunset_realm2.line13"},{t:545,type:"text",key:"story.sunset_realm.sunset_realm2.line14"},{t:585,type:"text",key:"story.sunset_realm.sunset_realm2.line15"},{t:625,type:"text",key:"story.sunset_realm.sunset_realm2.line16"},{t:665,type:"text",key:"story.sunset_realm.sunset_realm2.line17"},{t:705,type:"text",key:"story.sunset_realm.sunset_realm2.line18"},{t:745,type:"text",key:"story.sunset_realm.sunset_realm2.line19"},{t:785,type:"text_player",key:"story.sunset_realm.sunset_realm2.line20"},{t:825,type:"text",key:"story.sunset_realm.sunset_realm2.line21"},{t:865,type:"text",key:"story.sunset_realm.sunset_realm2.line22"},{t:905,type:"text",key:"story.sunset_realm.sunset_realm2.line23"},{t:945,type:"text",key:"story.sunset_realm.sunset_realm2.line24"},{t:985,type:"text",key:"story.sunset_realm.sunset_realm2.line25"},{t:1025,type:"text",key:"story.sunset_realm.sunset_realm2.line26"},{t:1065,type:"text_player",key:"story.sunset_realm.sunset_realm2.line27"},{t:1105,type:"text",key:"story.sunset_realm.sunset_realm2.line28"},{t:1145,type:"text",key:"story.sunset_realm.sunset_realm2.line29"}]

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1165,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:1185,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "sunset_realm_sunset_realm2"
data modify storage dialogtest:story run.scene_tick set value 0
