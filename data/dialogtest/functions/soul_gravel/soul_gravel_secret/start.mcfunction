# 設置已觸發，防止重複執行
scoreboard players set soul_gravel_secret_triggered soul_gravel_story 1

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks，*_player 表示帶玩家名稱）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.soul_gravel.soul_gravel_secret.line1"},{t:40,type:"text",key:"story.soul_gravel.soul_gravel_secret.line2"}]

# ctrl 軌：最後一行後 40 ticks 結束場景
data modify storage dialogtest:story run.ctrl set value [{t:80,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "soul_gravel_soul_gravel_secret"
data modify storage dialogtest:story run.scene_tick set value 0
