tellraw @a {"translate": "story.fire.fire1.line7"}

# 點頭動畫：先讓頭部向下
schedule function dialogtest:operations/anime/entity_nod/nod_down 5t

data modify storage dialogtest:story run.cd set value 40
data modify storage dialogtest:story run.dialog set value 7
