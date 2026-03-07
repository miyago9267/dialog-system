# 設置已觸發，防止重複執行
scoreboard players set grass4_triggered grass_story 1

# 場景設置
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true

# 召喚 AJ 角色（麥洛倪雅莎，woodgod variant）
# TODO: 確認召喚座標與朝向
execute positioned 0 0 0 rotated 0 0 run function animated_java:character/summon {args: {variant: 'woodgod'}}
execute positioned 0 0 0 run tag @e[sort=nearest,limit=1,tag=aj.character.root,distance=..2] add woodgod

# TODO: 確認玩家傳送座標
# tp @a X Y Z facing 0 0 0

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌（每行 40 ticks）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.grass.grass4.line1"},{t:40,type:"text",key:"story.grass.grass4.line2"},{t:80,type:"text",key:"story.grass.grass4.line3"},{t:120,type:"text",key:"story.grass.grass4.line4"},{t:160,type:"text",key:"story.grass.grass4.line5"},{t:200,type:"text",key:"story.grass.grass4.line6"},{t:240,type:"text",key:"story.grass.grass4.line7"},{t:280,type:"text",key:"story.grass.grass4.line8"},{t:320,type:"text",key:"story.grass.grass4.line9"}]

# union 軌：t=0 播放點頭動畫（與 line1「麥洛倪雅莎點了點頭」同步），t=31 切換回待機呼吸
data modify storage dialogtest:story run.union set value [{t:0,type:"anim_play",tag:"woodgod",anim:"nod"},{t:31,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"}]

# ctrl 軌：最後一行顯示後 40 ticks 執行 cleanup
data modify storage dialogtest:story run.ctrl set value [{t:360,type:"fn",fn:"dialogtest:grass/grass4/cleanup"}]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "grass_grass4"
data modify storage dialogtest:story run.scene_tick set value 0
