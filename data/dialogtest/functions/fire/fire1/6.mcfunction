tellraw @a {"translate": "story.fire.fire1.line7"}

# 村民點頭
schedule function dialogtest:operations/anime/entity_nod/nod_down 5t

# AJ 角色點頭（先停 breath，播 nod（約30f），之後恢復 breath）
execute as @e[tag=union] run function animated_java:character/animations/breath/stop
execute as @e[tag=union] run function animated_java:character/animations/nod/play
schedule function dialogtest:fire/fire1/aj_resume_breath 31t

data modify storage dialogtest:story run.cd set value 40
data modify storage dialogtest:story run.dialog set value 7
