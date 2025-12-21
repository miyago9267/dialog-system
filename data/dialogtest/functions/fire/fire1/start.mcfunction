execute positioned -2029 13 1764 rotated 40 0 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -2029 13 1764 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon item_display -2029 13 1764 {CustomName:'{"text":"尤尼恩","color":"white","bold":true}',CustomNameVisible:1b,Item:{id:"minecraft:barrier",Count:1b},Invisible:1b}

summon minecraft:villager -2029 13 1767 {NoAI:1b,Silent:1b,CustomName:'{"text":"鐵匠賽克","color":"gray"}',VillagerData:{profession:"minecraft:weaponsmith",level:2,type:"minecraft:plains"}}
tp @e[name="鐵匠賽克"] -2029 13 1767 180 0

data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.cd set value 1
data modify storage dialogtest:story run.chapter set value fire
data modify storage dialogtest:story run.paragraph set value fire1
data modify storage dialogtest:story run.dialog set value 0
