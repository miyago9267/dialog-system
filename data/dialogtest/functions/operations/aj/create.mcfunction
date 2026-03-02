# Summon AJ character at position with variant, then tag the root entity
# Args: tag, variant, x, y, z, rot
$execute positioned $(x) $(y) $(z) rotated $(rot) 0 run function animated_java:character/summon {args: {variant: '$(variant)'}}
$execute positioned $(x) $(y) $(z) run tag @e[sort=nearest,limit=1,tag=aj.character.root,distance=..2] add $(tag)
