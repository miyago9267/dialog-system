# 設置已觸發，防止重複執行
scoreboard players set ghost_town2_triggered ghost_town_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text_player",key:"story.ghost_town.ghost_town2.line1"},{t:65,type:"text",key:"story.ghost_town.ghost_town2.line2"},{t:145,type:"text_player",key:"story.ghost_town.ghost_town2.line3"},{t:225,type:"text",key:"story.ghost_town.ghost_town2.line4"},{t:265,type:"text",key:"story.ghost_town.ghost_town2.line5"},{t:345,type:"text_player",key:"story.ghost_town.ghost_town2.line6"},{t:425,type:"text",key:"story.ghost_town.ghost_town2.line7"},{t:465,type:"text",key:"story.ghost_town.ghost_town2.line8"},{t:545,type:"text_player",key:"story.ghost_town.ghost_town2.line9"},{t:625,type:"text_player",key:"story.ghost_town.ghost_town2.line10"}]

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:645,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:665,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "ghost_town_ghost_town2"
data modify storage dialogtest:story run.scene_tick set value 0
