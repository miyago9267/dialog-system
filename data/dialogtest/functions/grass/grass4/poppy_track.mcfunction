# 每 tick 讓罌粟跟隨木神右手骨骼動畫
# 由 tick.mcfunction 在 _grass4_poppy_tracking=1 時呼叫

# 把罌粟傳送到木神根實體位置（骨骼的物理基準點）
execute at @e[tag=woodgod] run tp @e[tag=grass4_poppy] ~ ~ ~

# 複製右手骨骼的完整 transformation（位移+旋轉+縮放）到罌粟
# 罌粟會出現在右手骨骼的視覺位置，跟著 give 動畫一起動
execute as @e[tag=woodgod] on passengers if entity @s[tag=aj.character.bone.right_arm] run data modify entity @e[tag=grass4_poppy,limit=1] transformation set from entity @s transformation
