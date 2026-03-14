# 設置已觸發，防止重複執行
scoreboard players set dead_kingdom5_triggered dead_kingdom_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.dead_kingdom.dead_kingdom5.line1"},{t:40,type:"text",key:"story.dead_kingdom.dead_kingdom5.line2"},{t:80,type:"text",key:"story.dead_kingdom.dead_kingdom5.line3"},{t:120,type:"text",key:"story.dead_kingdom.dead_kingdom5.line4"},{t:160,type:"text",key:"story.dead_kingdom.dead_kingdom5.line5"},{t:200,type:"text",key:"story.dead_kingdom.dead_kingdom5.line6"},{t:240,type:"text",key:"story.dead_kingdom.dead_kingdom5.line7"},{t:280,type:"text_player",key:"story.dead_kingdom.dead_kingdom5.line8"},{t:320,type:"text",key:"story.dead_kingdom.dead_kingdom5.line9"},{t:360,type:"text",key:"story.dead_kingdom.dead_kingdom5.line10"},{t:400,type:"text",key:"story.dead_kingdom.dead_kingdom5.line11"},{t:440,type:"text",key:"story.dead_kingdom.dead_kingdom5.line12"},{t:480,type:"text_player",key:"story.dead_kingdom.dead_kingdom5.line13"},{t:520,type:"text",key:"story.dead_kingdom.dead_kingdom5.line14"},{t:560,type:"text",key:"story.dead_kingdom.dead_kingdom5.line15"},{t:600,type:"text",key:"story.dead_kingdom.dead_kingdom5.line16"},{t:640,type:"text",key:"story.dead_kingdom.dead_kingdom5.line17"}]

# [DISABLED] action 軌（動作事件，每個指向 stub mcfunction）
# data modify storage dialogtest:story run.action set value [{t:520,type:"fn",fn:"dialogtest:dead_kingdom/dead_kingdom5/act1"}]
# act1 (t=520, line14): 堯稚克幻象，在發現玩家並追逐一定時間後會自動消失。

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:680,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "dead_kingdom_dead_kingdom5"
data modify storage dialogtest:story run.scene_tick set value 0
