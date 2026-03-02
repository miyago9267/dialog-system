# 停止動畫（macro）
# 事件格式：{t: N, type: "anim_stop", tag: "TAG", anim: "ANIM_NAME"}
$execute as @e[tag=$(tag)] run function animated_java:character/animations/$(anim)/stop
