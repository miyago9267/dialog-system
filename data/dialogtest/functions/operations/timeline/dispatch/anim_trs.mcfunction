# 動畫切換（停舊→播新，macro）
# 事件格式：{t: N, type: "anim_trs", tag: "TAG", from: "OLD_ANIM", to: "NEW_ANIM"}
$execute as @e[tag=$(tag)] run function animated_java:character/animations/$(from)/stop
$execute as @e[tag=$(tag)] run function animated_java:character/animations/$(to)/play
