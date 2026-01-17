# 設置已觸發，防止重複執行
scoreboard players set fire1_triggered fire_story 1

# 鎖定玩家移動和視角
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true
effect give @a blindness 1 0 true

execute positioned -2029 13 1764 rotated 40 0 run function animated_java:character/summon {args: {variant: 'union'}}
execute positioned -2029 13 1764 run tag @e[sort=nearest,limit=1,tag=aj.character.root] add union
summon item_display -2029 13 1764 {CustomName:'{"text":"尤尼恩","color":"white","bold":true}',CustomNameVisible:1b,Item:{id:"minecraft:barrier",Count:1b},Invisible:1b,Tags:["fire1"]}

summon minecraft:villager -2029 13 1767 {NoAI:1b,Silent:1b,CustomName:'{"text":"鐵匠賽克","color":"gray"}',VillagerData:{profession:"minecraft:weaponsmith",level:2,type:"minecraft:plains"},Tags:["fire1","nod"]}

# 讓村民朝向玩家
execute as @e[name="鐵匠賽克",tag=fire1] at @s run tp @s ~ ~ ~ facing -2032 13 1765

# 傳送玩家到指定位置並面向村民
tp @a -2032 13 1765 facing -2029 13 1767

data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.cd set value 1
data modify storage dialogtest:story run.chapter set value fire
data modify storage dialogtest:story run.paragraph set value fire1
data modify storage dialogtest:story run.dialog set value 0
