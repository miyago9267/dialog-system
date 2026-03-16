# 設置已觸發，防止重複執行
scoreboard players set ghost_town4_triggered ghost_town_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text_player",key:"story.ghost_town.ghost_town4.line1"},{t:65,type:"text",key:"story.ghost_town.ghost_town4.line2"},{t:125,type:"text_player",key:"story.ghost_town.ghost_town4.line3"},{t:185,type:"text",key:"story.ghost_town.ghost_town4.line4"},{t:225,type:"text_player",key:"story.ghost_town.ghost_town4.line5"},{t:285,type:"text",key:"story.ghost_town.ghost_town4.line6"},{t:345,type:"text",key:"story.ghost_town.ghost_town4.line7"},{t:385,type:"text",key:"story.ghost_town.ghost_town4.line8"},{t:445,type:"text",key:"story.ghost_town.ghost_town4.line9"},{t:505,type:"text",key:"story.ghost_town.ghost_town4.line10"},{t:545,type:"text",key:"story.ghost_town.ghost_town4.line11"},{t:605,type:"text",key:"story.ghost_town.ghost_town4.line12"},{t:665,type:"text",key:"story.ghost_town.ghost_town4.line13"},{t:705,type:"text_player",key:"story.ghost_town.ghost_town4.line14"},{t:765,type:"text",key:"story.ghost_town.ghost_town4.line15"},{t:825,type:"text",key:"story.ghost_town.ghost_town4.line16"},{t:865,type:"text",key:"story.ghost_town.ghost_town4.line17"},{t:925,type:"text",key:"story.ghost_town.ghost_town4.line18"},{t:985,type:"text",key:"story.ghost_town.ghost_town4.line19"}]

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:1005,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:1025,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "ghost_town_ghost_town4"
data modify storage dialogtest:story run.scene_tick set value 0
