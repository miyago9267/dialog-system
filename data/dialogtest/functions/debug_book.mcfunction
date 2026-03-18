# Debug 書本 — 可互動的劇情測試工具書

give @s written_book{display:{Name:'[{"text":"Debug Book","color":"light_purple","italic":false}]'},title:"",author:"dialogtest",HideFlags:127b,\
pages:[\
'[\
{"text":"══ 傳送面板 ══\\n\\n","bold":true},\
{"text":"── 火源 ──\\n","color":"red","bold":true},\
{"text":"  [fire1] ","color":"gold","clickEvent":{"action":"run_command","value":"/tp @s -2031 14 1760"}},\
{"text":"[fire2] ","color":"gold","clickEvent":{"action":"run_command","value":"/tp @s -2399 18 1727"}},\
{"text":"[fire3]","color":"gold","clickEvent":{"action":"run_command","value":"/tp @s -2396 18 1727"}},\
{"text":"\\n\\n── 水源 ──\\n","color":"blue","bold":true},\
{"text":"  [water1] ","color":"aqua","clickEvent":{"action":"run_command","value":"/tp @s -1749 74 1502"}},\
{"text":"[water2]","color":"aqua","clickEvent":{"action":"run_command","value":"/tp @s -1749 12 1556"}},\
{"text":"\\n  [water3] ","color":"aqua","clickEvent":{"action":"run_command","value":"/tp @s -1749 12 1570"}},\
{"text":"[gate]","color":"aqua","clickEvent":{"action":"run_command","value":"/tp @s -1749 20 1541"}}\
]',\
'[\
{"text":"── 木源 ──\\n","color":"green","bold":true},\
{"text":"  [grass1] ","color":"dark_green","clickEvent":{"action":"run_command","value":"/tp @s -1403 6 1869"}},\
{"text":"[grass2]","color":"dark_green","clickEvent":{"action":"run_command","value":"/tp @s -1214 5 1790"}},\
{"text":"\\n  [grass3]","color":"dark_green","clickEvent":{"action":"run_command","value":"/tp @s -916 6 1916"}},\
{"text":"\\n\\n── 光源 ──\\n","color":"yellow","bold":true},\
{"text":"  [light1] ","color":"gold","clickEvent":{"action":"run_command","value":"/tp @s -1775 82 2112"}},\
{"text":"[light2]","color":"gold","clickEvent":{"action":"run_command","value":"/tp @s -1835 32 2154"}},\
{"text":"\\n  [light3]","color":"gold","clickEvent":{"action":"run_command","value":"/tp @s -1707 31 2154"}}\
]',\
'[\
{"text":"══ 觸發劇情 ══\\n\\n","bold":true},\
{"text":"── 火源 ──\\n","color":"red","bold":true},\
{"text":"  [fire1] ","color":"red","clickEvent":{"action":"run_command","value":"/function dialogtest:fire/fire1/start"}},\
{"text":"[fire2] ","color":"red","clickEvent":{"action":"run_command","value":"/function dialogtest:fire/fire2/start"}},\
{"text":"[fire3]","color":"red","clickEvent":{"action":"run_command","value":"/scoreboard players set fire3_trigger story_progress 1"}},\
{"text":"\\n\\n── 水源 ──\\n","color":"blue","bold":true},\
{"text":"  [water1] ","color":"dark_aqua","clickEvent":{"action":"run_command","value":"/function dialogtest:water/water1/start"}},\
{"text":"[water2]","color":"dark_aqua","clickEvent":{"action":"run_command","value":"/function dialogtest:water/water2/start"}},\
{"text":"\\n  [water3] ","color":"dark_aqua","clickEvent":{"action":"run_command","value":"/function dialogtest:water/water3/start"}},\
{"text":"[water4]","color":"dark_aqua","clickEvent":{"action":"run_command","value":"/scoreboard players set water4_trigger story_progress 1"}},\
{"text":"\\n  [gate]","color":"dark_aqua","clickEvent":{"action":"run_command","value":"/function dialogtest:water/water_gate/start"}}\
]',\
'[\
{"text":"── 木源 ──\\n","color":"green","bold":true},\
{"text":"  [grass1] ","color":"dark_green","clickEvent":{"action":"run_command","value":"/function dialogtest:grass/grass1/start"}},\
{"text":"[grass2]","color":"dark_green","clickEvent":{"action":"run_command","value":"/function dialogtest:grass/grass2/start"}},\
{"text":"\\n  [grass3] ","color":"dark_green","clickEvent":{"action":"run_command","value":"/function dialogtest:grass/grass3/start"}},\
{"text":"[grass4]","color":"dark_green","clickEvent":{"action":"run_command","value":"/scoreboard players set grass4_trigger story_progress 1"}},\
{"text":"\\n\\n── 光源 ──\\n","color":"yellow","bold":true},\
{"text":"  [light1] ","color":"yellow","clickEvent":{"action":"run_command","value":"/function dialogtest:light/light1/start"}},\
{"text":"[light2]","color":"yellow","clickEvent":{"action":"run_command","value":"/function dialogtest:light/light2/start"}},\
{"text":"\\n  [light3] ","color":"yellow","clickEvent":{"action":"run_command","value":"/function dialogtest:light/light3/start"}},\
{"text":"[light4]","color":"yellow","clickEvent":{"action":"run_command","value":"/scoreboard players set light4_trigger story_progress 1"}}\
]',\
'[\
{"text":"══ 工具 ══\\n\\n","bold":true},\
{"text":"[強制清除]\\n","color":"dark_red","bold":true,"clickEvent":{"action":"run_command","value":"/function dialogtest:force_cleanup"}},\
{"text":"[重置觸發點]\\n\\n","color":"red","clickEvent":{"action":"run_command","value":"/function dialogtest:reset_triggers"}},\
{"text":"[保留 ON] ","color":"green","clickEvent":{"action":"run_command","value":"/scoreboard players set _keep_triggers dialog_timer 1"}},\
{"text":"[保留 OFF]\\n\\n","color":"red","clickEvent":{"action":"run_command","value":"/scoreboard players set _keep_triggers dialog_timer 0"}},\
{"text":"[再次取得書本]","color":"light_purple","clickEvent":{"action":"run_command","value":"/function dialogtest:debug_book"}}\
]'\
]}
