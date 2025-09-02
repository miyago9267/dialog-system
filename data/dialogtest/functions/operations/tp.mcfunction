# tp operation
# Schema
# - storage dialogtest:story current.target -> "@a" || "@p"
# - storage dialogtest:story current.pos -> [x,y,z]

data modify storage dialogtest:story teleport set value {}

data modify storage dialogtest:story teleport.target set from storage dialogtest:story current.target

data modify storage dialogtest:story teleport.to_x set from storage dialogtest:story current.pos[0]
data modify storage dialogtest:story teleport.to_y set from storage dialogtest:story current.pos[1]
data modify storage dialogtest:story teleport.to_z set from storage dialogtest:story current.pos[2]

function dialogtest:operations/teleport/main with storage dialogtest:story teleport