# tp operation
# Schema
# - storage dialogtest:story current.target -> "@a" || "@p"
# - storage dialogtest:story current.pos -> [x,y,z]

tellraw @a {"text":"[Debug] teleporting...","color":"gray","italic":true}

execute if data storage dialogtest:story current.pos run summon minecraft:interaction ~ ~ ~ {Tags:["dialog_tp"]}
execute unless data storage dialogtest:story current.pos run tellraw @a {"text":"[Error] No position or location specified for tp operation.","color":"red"}
execute unless data storage dialogtest:story current.pos run return 0

execute as @e[type=minecraft:interaction,tag=dialog_tp,limit=1,sort=nearest] run execute store result entity @s Pos[0] double 1 run data get storage dialogtest:story current.pos[0]
execute as @e[type=minecraft:interaction,tag=dialog_tp,limit=1,sort=nearest] run execute store result entity @s Pos[1] double 1 run data get storage dialogtest:story current.pos[1]
execute as @e[type=minecraft:interaction,tag=dialog_tp,limit=1,sort=nearest] run execute store result entity @s Pos[2] double 1 run data get storage dialogtest:story current.pos[2]

# Debug
execute as @e[type=minecraft:interaction,tag=dialog_tp,limit=1,sort=nearest] run tellraw @a [{"text":"[TP Anchor] ","color":"yellow"},{"selector":"@s"},{"text":" Pos=","color":"gray"},{"nbt":"Pos","entity":"@s"}]

# default @a
execute if data storage dialogtest:story current{target:"@a"} as @e[type=minecraft:interaction,tag=dialog_tp,limit=1,sort=nearest] run tp @a @s
execute if data storage dialogtest:story current{target:"@p"} as @e[type=minecraft:interaction,tag=dialog_tp,limit=1,sort=nearest] run tp @p @s
execute unless data storage dialogtest:story current{target:"@a"} unless data storage dialogtest:story current{target:"@p"} as @e[type=minecraft:interaction,tag=dialog_tp,limit=1,sort=nearest] run tp @a @s

# clear entity
execute as @e[type=minecraft:interaction,tag=dialog_tp,limit=1,sort=nearest] run kill @s