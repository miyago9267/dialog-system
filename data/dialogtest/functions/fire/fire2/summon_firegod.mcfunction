# 召喚火靈神（ctrl 軌 t=290 觸發）

# 清除火柱實體
kill @e[tag=fire2_pillar]
kill @e[tag=fire2_pillar2]

# 召喚火靈神 AJ 角色（面向 -90 0，即朝西）
execute positioned -2385 18 1727 rotated -90 0 run function animated_java:character/summon {args: {variant: 'firegod'}}
execute positioned -2385 18 1727 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add firegod

# 召喚名牌
summon item_display -2385 18 1727 {CustomName:'{"text":"阿多賽忒喀","color":"red","bold":true}',CustomNameVisible:1b,Item:{id:"minecraft:barrier",Count:1b},Invisible:1b,Tags:["fire2_entity"]}

# 爆炸音效
execute at @a run playsound minecraft:entity.generic.explode ambient @a ^ ^ ^
