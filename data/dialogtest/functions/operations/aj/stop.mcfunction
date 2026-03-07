# Stop animation on tagged AJ character
# Args: tag, anim
$execute as @e[tag=$(tag)] run function animated_java:character/animations/$(anim)/stop
