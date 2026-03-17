# 大門消除 + 白色爆炸粒子
# 門範圍: -1746 25 1558 ~ -1752 12 1558
fill -1746 25 1558 -1752 12 1558 air

# 白色爆炸粒子（多點散布覆蓋整面門）
particle minecraft:flash -1749 18 1558 3 6 0.5 0 10 force
particle minecraft:explosion -1749 20 1558 2 3 0.5 0.1 8 force
particle minecraft:explosion -1749 15 1558 2 3 0.5 0.1 8 force
particle minecraft:end_rod -1749 18 1558 4 7 1 0.2 40 force
particle minecraft:cloud -1749 18 1558 3 6 0.5 0.05 20 force

# 音效
playsound minecraft:entity.generic.explode ambient @a -1749 18 1558 2 1.2
playsound minecraft:block.glass.break ambient @a -1749 18 1558 2 0.5
