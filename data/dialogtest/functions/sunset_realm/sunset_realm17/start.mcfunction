

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.sunset_realm.sunset_realm17.line1"},{t:65,type:"text",key:"story.sunset_realm.sunset_realm17.line2"},{t:145,type:"text",key:"story.sunset_realm.sunset_realm17.line3"},{t:225,type:"text",key:"story.sunset_realm.sunset_realm17.line4"},{t:265,type:"text",key:"story.sunset_realm.sunset_realm17.line5"},{t:345,type:"text",key:"story.sunset_realm.sunset_realm17.line6"},{t:425,type:"text",key:"story.sunset_realm.sunset_realm17.line7"},{t:465,type:"text",key:"story.sunset_realm.sunset_realm17.line8"},{t:545,type:"text",key:"story.sunset_realm.sunset_realm17.line9"},{t:625,type:"text",key:"story.sunset_realm.sunset_realm17.line10"},{t:665,type:"text",key:"story.sunset_realm.sunset_realm17.line11"},{t:745,type:"text",key:"story.sunset_realm.sunset_realm17.line12"},{t:825,type:"text",key:"story.sunset_realm.sunset_realm17.line13"},{t:865,type:"text",key:"story.sunset_realm.sunset_realm17.line14"}]

# ctrl 軌：最後一行顯示後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:925,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:945,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "sunset_realm_sunset_realm17"
data modify storage dialogtest:story run.scene_tick set value 0
