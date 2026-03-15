# 設置已觸發，防止重複執行
scoreboard players set tower2_triggered tower_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text",key:"story.tower.tower2.line1"},{t:65,type:"text",key:"story.tower.tower2.line2"},{t:145,type:"text",key:"story.tower.tower2.line3"},{t:225,type:"text",key:"story.tower.tower2.line4"},{t:265,type:"text",key:"story.tower.tower2.line5"},{t:345,type:"text",key:"story.tower.tower2.line6"},{t:425,type:"text",key:"story.tower.tower2.line7"},{t:465,type:"text",key:"story.tower.tower2.line8"},{t:545,type:"text",key:"story.tower.tower2.line9"},{t:625,type:"text",key:"story.tower.tower2.line10"},{t:665,type:"text",key:"story.tower.tower2.line11"},{t:745,type:"text",key:"story.tower.tower2.line12"},{t:825,type:"text",key:"story.tower.tower2.line13"},{t:865,type:"text",key:"story.tower.tower2.line14"},{t:945,type:"text",key:"story.tower.tower2.line15"},{t:1025,type:"text",key:"story.tower.tower2.line16"},{t:1065,type:"text",key:"story.tower.tower2.line17"},{t:1145,type:"text",key:"story.tower.tower2.line18"},{t:1225,type:"text",key:"story.tower.tower2.line19"},{t:1265,type:"text",key:"story.tower.tower2.line20"},{t:1345,type:"text",key:"story.tower.tower2.line21"},{t:1425,type:"text",key:"story.tower.tower2.line22"},{t:1465,type:"text",key:"story.tower.tower2.line23"},{t:1545,type:"text",key:"story.tower.tower2.line24"},{t:1625,type:"text",key:"story.tower.tower2.line25"},{t:1665,type:"text",key:"story.tower.tower2.line26"},{t:1745,type:"text",key:"story.tower.tower2.line27"},{t:1825,type:"text",key:"story.tower.tower2.line28"},{t:1865,type:"text",key:"story.tower.tower2.line29"},{t:1945,type:"text",key:"story.tower.tower2.line30"},{t:2025,type:"text",key:"story.tower.tower2.line31"},{t:2065,type:"text",key:"story.tower.tower2.line32"},{t:2145,type:"text_player",key:"story.tower.tower2.line33"},{t:2225,type:"text",key:"story.tower.tower2.line34"},{t:2265,type:"text",key:"story.tower.tower2.line35"},{t:2345,type:"text",key:"story.tower.tower2.line36"},{t:2425,type:"text",key:"story.tower.tower2.line37"},{t:2465,type:"text",key:"story.tower.tower2.line38"},{t:2545,type:"text",key:"story.tower.tower2.line39"}]

# [DISABLED] action 軌（動作事件，每個指向 stub mcfunction）
# data modify storage dialogtest:story run.action set value [{t:1025,type:"fn",fn:"dialogtest:tower/tower2/act1"}]
# act1 (t=1000, line26): 看向菲恩特

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:2565,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:2625,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "tower_tower2"
data modify storage dialogtest:story run.scene_tick set value 0
