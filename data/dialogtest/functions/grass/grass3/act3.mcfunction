# 木神抬手，水晶施放射線匯聚成魔法陣
# 觸發時機：t=185（line3）

# 水晶射線粒子（從四周射向木神）
particle minecraft:end_rod -945 8 1922 4 2 4 0.02 40 force
particle minecraft:enchant -945 7 1922 3 1 3 1 30 force

# 魔法陣匯聚效果
particle minecraft:witch -945 6 1922 2 0.1 2 0.5 20 force
particle minecraft:flash -945 7 1922 0.5 0.5 0.5 0 3 force

# 音效
playsound minecraft:block.beacon.activate ambient @a -945 6 1922 2 0.6
playsound minecraft:block.amethyst_cluster.break ambient @a -945 6 1922 2 1.2
