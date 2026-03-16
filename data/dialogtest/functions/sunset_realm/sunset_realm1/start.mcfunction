# 設置已觸發，防止重複執行
scoreboard players set sunset_realm1_triggered sunset_realm_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.sunset_realm.sunset_realm1.line1"},{t:65,type:"text",key:"story.sunset_realm.sunset_realm1.line2"},{t:125,type:"text_player",key:"story.sunset_realm.sunset_realm1.line3"},{t:185,type:"text",key:"story.sunset_realm.sunset_realm1.line4"},{t:225,type:"text",key:"story.sunset_realm.sunset_realm1.line5"},{t:285,type:"text",key:"story.sunset_realm.sunset_realm1.line6"},{t:345,type:"text",key:"story.sunset_realm.sunset_realm1.line7"},{t:385,type:"text",key:"story.sunset_realm.sunset_realm1.line8"},{t:445,type:"text",key:"story.sunset_realm.sunset_realm1.line9"},{t:505,type:"text",key:"story.sunset_realm.sunset_realm1.line10"},{t:545,type:"text",key:"story.sunset_realm.sunset_realm1.line11"}]

# [DISABLED] action 軌（動作事件，每個指向 stub mcfunction）
# data modify storage dialogtest:story run.action set value [{t:25,type:"fn",fn:"dialogtest:sunset_realm/sunset_realm1/act1"}]
# act1 (t=0, line1): 沙壁村、圖書院、夕煌鎮、政令廳、夕煌神廟、祭祀所

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:585,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:605,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "sunset_realm_sunset_realm1"
data modify storage dialogtest:story run.scene_tick set value 0
