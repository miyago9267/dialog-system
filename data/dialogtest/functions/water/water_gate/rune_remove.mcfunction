# 符文消失
# PENDING: 確認符文的實際範圍，可能需要 fill 更大區域
setblock -1761 10 1392 air destroy
execute positioned -1761 10 1392 run playsound minecraft:block.glass.break ambient @a ~ ~ ~ 2 0.5
particle minecraft:flash -1761 10 1392 0 0 0 0 1 force
