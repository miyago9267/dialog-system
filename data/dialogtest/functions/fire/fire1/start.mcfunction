# 設置已觸發，防止重複執行
scoreboard players set fire1_triggered fire_story 1

# 鎖定玩家移動和視角
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true
effect give @a blindness 1 0 true

# 召喚 AJ 角色（尤尼恩）—— breath 由 union 軌在 t=0 觸發，不在此重複
execute positioned -2029 13 1764 rotated 40 0 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -2029 13 1764 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union

# 召喚場景實體
summon item_display -2029 13 1764 {CustomName:'{"text":"尤尼恩","color":"white","bold":true}',CustomNameVisible:1b,Item:{id:"minecraft:barrier",Count:1b},Invisible:1b,Tags:["fire1"]}
summon minecraft:villager -2029 13 1767 {NoAI:1b,Silent:1b,CustomName:'{"text":"鐵匠賽克","color":"gray"}',VillagerData:{profession:"minecraft:weaponsmith",level:2,type:"minecraft:plains"},Tags:["fire1","nod"]}
execute as @e[name="鐵匠賽克",tag=fire1] at @s run tp @s ~ ~ ~ facing -2032 13 1765

# 傳送玩家
tp @a -2032 13 1765 facing -2029 13 1767

# 重置村民移動狀態
scoreboard players set _fire1_villager_walking dialog_timer 0
data modify storage dialogtest:story run.villager_walk_phase set value 0

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌：台詞序列（每行 40 ticks）
# line1-2 為玩家台詞（帶角色名），其餘為純文字
data modify storage dialogtest:story run.text set value [\
  {t:0,   type:"text_player", key:"story.fire.fire1.line1"},\
  {t:40,  type:"text_player", key:"story.fire.fire1.line2"},\
  {t:80,  type:"text",        key:"story.fire.fire1.line3"},\
  {t:120, type:"text",        key:"story.fire.fire1.line4"},\
  {t:160, type:"text",        key:"story.fire.fire1.line5"},\
  {t:200, type:"text",        key:"story.fire.fire1.line6"},\
  {t:240, type:"text",        key:"story.fire.fire1.line7"},\
  {t:280, type:"text",        key:"story.fire.fire1.line8"},\
  {t:320, type:"text",        key:"story.fire.fire1.line9"},\
  {t:360, type:"text",        key:"story.fire.fire1.line10"},\
  {t:400, type:"text",        key:"story.fire.fire1.line11"},\
  {t:440, type:"text",        key:"story.fire.fire1.line12"},\
  {t:480, type:"text",        key:"story.fire.fire1.line13"},\
  {t:520, type:"text",        key:"story.fire.fire1.line14"},\
  {t:560, type:"text",        key:"story.fire.fire1.line15"}\
]

# union 軌：AJ 角色動畫
# t=0 開始待機，t=240 點頭（與 line7 同步），t=271（nod ~30f）恢復待機
data modify storage dialogtest:story run.union set value [\
  {t:0,   type:"anim_play", tag:"union", anim:"breath"},\
  {t:240, type:"anim_trs",  tag:"union", from:"breath", to:"nod"},\
  {t:271, type:"anim_trs",  tag:"union", from:"nod",    to:"breath"}\
]

# villager 軌：鐵匠賽克移動控制
# t=360（line10 同步）開始走向靜水台方向，t=440（line12 同步）換目標
data modify storage dialogtest:story run.villager set value [\
  {t:360, type:"fn", fn:"dialogtest:fire/fire1/villager_walk_to_dest1"},\
  {t:440, type:"fn", fn:"dialogtest:fire/fire1/villager_walk_to_dest2"}\
]

# ctrl 軌：場景控制（line15 顯示後 40 ticks 執行 cleanup）
data modify storage dialogtest:story run.ctrl set value [\
  {t:600, type:"fn", fn:"dialogtest:fire/fire1/cleanup"}\
]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing   set value 1b
data modify storage dialogtest:story run.mode      set value "timeline"
data modify storage dialogtest:story run.scene     set value "fire1"
data modify storage dialogtest:story run.scene_tick set value 0
