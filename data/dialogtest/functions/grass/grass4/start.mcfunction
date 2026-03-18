# 設置已觸發，防止重複執行
scoreboard players set grass4_triggered story_progress 1

# ── 場景設置（站位） ──────────────────────────────────────────
gamemode spectator @a

# 木神（麥洛倪雅莎）：-945 6 1922，面向玩家
execute positioned -945 6 1922 facing -932 6 1922 run function animated_java:character/summon {args: {variant: 'woodgod'}}
execute positioned -945 6 1922 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add woodgod
execute as @e[tag=woodgod] at @s run tp @s ~ ~ ~ facing -932 6 1922
summon text_display -945 8 1922 {text:'{"text":"麥洛倪雅莎","color":"green","bold":true}',billboard:"center",Tags:["grass4_entity","grass4_woodgod_name"]}

# 尤尼恩：-936 6 1925，面向木神
execute positioned -936 6 1925 facing -945 6 1922 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -936 6 1925 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
execute as @e[tag=union] at @s run tp @s ~ ~ ~ facing -945 6 1922
summon text_display -936 8 1925 {text:'{"text":"尤尼恩","color":"white","bold":true}',billboard:"center",Tags:["grass4_entity"]}

# 主角視角：-932 6 1922，面向木神
summon marker -932 6 1922 {Rotation:[90.0f,0.0f],Tags:["scene_camera"]}
execute as @e[tag=scene_camera] at @s run tp @s ~ ~ ~ facing -945 6 1922
tp @a -932 6 1922 facing -945 6 1922

# ── 時間軸資料 ──────────────────────────────────────────────
# text 軌
data modify storage dialogtest:story run.text set value [\
{t:25,type:"text",key:"story.grass.grass4.line1"},\
{t:105,type:"text",key:"story.grass.grass4.line2"},\
{t:185,type:"text",key:"story.grass.grass4.line3"},\
{t:425,type:"text",key:"story.grass.grass4.line4"},\
{t:505,type:"text",key:"story.grass.grass4.line5"},\
{t:585,type:"text",key:"story.grass.grass4.line6"},\
{t:665,type:"text",key:"story.grass.grass4.line7"},\
{t:745,type:"text",key:"story.grass.grass4.line8"}\
]

# action 軌
data modify storage dialogtest:story run.action set value [\
{t:25,type:"anim_trs",tag:"woodgod",from:"breath",to:"nod"},\
{t:45,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"},\
{t:105,type:"anim_trs",tag:"woodgod",from:"breath",to:"nod"},\
{t:125,type:"anim_trs",tag:"woodgod",from:"nod",to:"breath"},\
{t:195,type:"fn",fn:"dialogtest:grass/grass4/move_to_union"},\
{t:215,type:"fn",fn:"dialogtest:grass/grass4/give_to_union"},\
{t:290,type:"fn",fn:"dialogtest:grass/grass4/give_to_union_end"},\
{t:310,type:"fn",fn:"dialogtest:grass/grass4/move_to_player"},\
{t:330,type:"fn",fn:"dialogtest:grass/grass4/give_to_player"},\
{t:405,type:"fn",fn:"dialogtest:grass/grass4/give_to_player_end"},\
{t:585,type:"fn",fn:"dialogtest:grass/grass4/act4"}\
]
# t=25:  木神點頭（花兒好）
# t=105: 木神點頭（你們也好）
# t=195: 瞬移至尤尼恩旁 + 苞子粒子
# t=215: give 動畫 + 右手舉罌粟
# t=290: 花轉移尤尼恩 + 收手
# t=310: 瞬移至主角旁 + 苞子粒子 + 尤尼恩轉向
# t=330: give 動畫 + 右手舉罌粟
# t=405: 花轉移主角 + 收手
# t=585: 苞子花粒子消失

# ctrl 軌
data modify storage dialogtest:story run.ctrl set value [\
{t:785,type:"fn",fn:"dialogtest:operations/transition/fade_to_black"},\
{t:825,type:"fn",fn:"dialogtest:grass/grass4/cleanup"}\
]

# ── 啟動時間軸 ──────────────────────────────────────────────
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "grass_grass4"
data modify storage dialogtest:story run.scene_tick set value 0
