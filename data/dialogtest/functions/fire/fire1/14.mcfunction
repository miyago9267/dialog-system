tellraw @a {"translate": "story.fire.fire1.line15"}

tp @e[name="鐵匠賽克"] -2029 -64 1767
kill @e[name="鐵匠賽克"]
kill @e[name="尤尼恩"]
execute as @e[tag=union] run function animated_java:character/remove/this

data modify storage dialogtest:story run.playing set value 0b
data modify storage dialogtest:story run.cd set value 40
data modify storage dialogtest:story run.dialog set value 0
