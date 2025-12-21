tellraw @a {"translate": "story.fire.fire1.line7"}

execute as @e[type=minecraft:villager,tag=nod,limit=1] run data merge entity @s {Pose:{Head:[25f,0f,0f]}}

schedule function dialogtest:operations/anime/entity_nod/nod_up 5t

data modify storage dialogtest:story run.cd set value 40
data modify storage dialogtest:story run.dialog set value 7
