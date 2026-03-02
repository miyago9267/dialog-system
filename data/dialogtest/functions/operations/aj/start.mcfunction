# Play animation on tagged AJ character (executes as root entity)
# Args: tag, anim
$execute as @e[tag=$(tag)] run function animated_java:character/animations/$(anim)/play
