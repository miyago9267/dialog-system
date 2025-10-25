# animated java operation
# Schema
# - storage dialogtest:story current.action -> "create" | "play" | "stop"
# - storage dialogtest:story current.args -> {arg1:value1, arg2:value2, ...}
## if (action == "create")
### - storage dialogtest:story current.args.name -> "name_of_animation"

data modify storage dialogtest:story teleport set value {}

data modify storage dialogtest:story teleport.action set from storage dialogtest:story current.action

data modify storage dialogtest:story teleport.to_x set from storage dialogtest:story current.pos[0]
data modify storage dialogtest:story teleport.to_y set from storage dialogtest:story current.pos[1]
data modify storage dialogtest:story teleport.to_z set from storage dialogtest:story current.pos[2]

function dialogtest:operations/teleport/main with storage dialogtest:story teleport