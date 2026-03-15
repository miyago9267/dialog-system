

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.sunset_realm.sunset_realm15.line1"},{t:65,type:"text",key:"story.sunset_realm.sunset_realm15.line2"},{t:145,type:"text",key:"story.sunset_realm.sunset_realm15.line3"},{t:225,type:"text",key:"story.sunset_realm.sunset_realm15.line4"},{t:265,type:"text",key:"story.sunset_realm.sunset_realm15.line5"},{t:345,type:"text",key:"story.sunset_realm.sunset_realm15.line6"},{t:425,type:"text",key:"story.sunset_realm.sunset_realm15.line7"},{t:465,type:"text",key:"story.sunset_realm.sunset_realm15.line8"},{t:545,type:"text",key:"story.sunset_realm.sunset_realm15.line9"},{t:625,type:"text",key:"story.sunset_realm.sunset_realm15.line10"},{t:665,type:"text",key:"story.sunset_realm.sunset_realm15.line11"},{t:745,type:"text",key:"story.sunset_realm.sunset_realm15.line12"},{t:825,type:"text",key:"story.sunset_realm.sunset_realm15.line13"},{t:865,type:"text",key:"story.sunset_realm.sunset_realm15.line14"},{t:945,type:"text",key:"story.sunset_realm.sunset_realm15.line15"},{t:1025,type:"text",key:"story.sunset_realm.sunset_realm15.line16"},{t:1065,type:"text",key:"story.sunset_realm.sunset_realm15.line17"},{t:1145,type:"text",key:"story.sunset_realm.sunset_realm15.line18"},{t:1225,type:"text",key:"story.sunset_realm.sunset_realm15.line19"},{t:1265,type:"text",key:"story.sunset_realm.sunset_realm15.line20"},{t:1345,type:"text",key:"story.sunset_realm.sunset_realm15.line21"},{t:1425,type:"text",key:"story.sunset_realm.sunset_realm15.line22"},{t:1465,type:"text",key:"story.sunset_realm.sunset_realm15.line23"},{t:1545,type:"text",key:"story.sunset_realm.sunset_realm15.line24"},{t:1625,type:"text",key:"story.sunset_realm.sunset_realm15.line25"},{t:1665,type:"text",key:"story.sunset_realm.sunset_realm15.line26"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1725,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:1745,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "sunset_realm_sunset_realm15"
data modify storage dialogtest:story run.scene_tick set value 0
