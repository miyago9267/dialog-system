# 設置已觸發，防止重複執行
scoreboard players set dead_kingdom1_triggered dead_kingdom_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:25,type:"text_player",key:"story.dead_kingdom.dead_kingdom1.line1"},{t:65,type:"text",key:"story.dead_kingdom.dead_kingdom1.line2"},{t:145,type:"text",key:"story.dead_kingdom.dead_kingdom1.line3"},{t:225,type:"text_player",key:"story.dead_kingdom.dead_kingdom1.line4"},{t:265,type:"text",key:"story.dead_kingdom.dead_kingdom1.line5"},{t:345,type:"text_player",key:"story.dead_kingdom.dead_kingdom1.line6"},{t:425,type:"text",key:"story.dead_kingdom.dead_kingdom1.line7"},{t:465,type:"text",key:"story.dead_kingdom.dead_kingdom1.line8"},{t:545,type:"text",key:"story.dead_kingdom.dead_kingdom1.line9"},{t:625,type:"text",key:"story.dead_kingdom.dead_kingdom1.line10"}]

# [DISABLED] action 軌（動作事件，每個指向 stub mcfunction）
# data modify storage dialogtest:story run.action set value [{t:25,type:"fn",fn:"dialogtest:dead_kingdom/dead_kingdom1/act1"}]
# act1 (t=0, line1): (中庭鎮守四石像，轟獸坐南朝北，巫女坐東朝南，斧者坐北朝西，地魂坐西朝東)
轟獸-苦力怕:主臥室
巫女-女巫:夾層密室
斧者-衛道士:閣樓
地魂-骷髏:會議廳

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:645,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},{t:665,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "dead_kingdom_dead_kingdom1"
data modify storage dialogtest:story run.scene_tick set value 0
