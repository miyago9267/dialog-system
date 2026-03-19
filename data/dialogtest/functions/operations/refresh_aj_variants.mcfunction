# 強制重新套用所有 AJ 角色的 variant 材質
# 修復地圖載入時資源包尚未就緒導致的材質不顯示問題
# 由 timeline/tick 在 scene_tick=5 時呼叫

execute as @e[tag=union,tag=aj.character.root] run function animated_java:character/variants/union/apply
execute as @e[tag=woodgod,tag=aj.character.root] run function animated_java:character/variants/woodgod/apply
execute as @e[tag=firegod,tag=aj.character.root] run function animated_java:character/variants/firegod/apply
execute as @e[tag=lightgod,tag=aj.character.root] run function animated_java:character/variants/lightgod/apply
execute as @e[tag=watergod,tag=aj.character.root] run function animated_java:character/variants/watergod/apply
execute as @e[tag=migale,tag=aj.character.root] run function animated_java:character/variants/migale/apply
