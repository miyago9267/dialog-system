# 開始水靈座大門開啟特效
# 設置持續粒子標記（由 effects_tick 驅動）
scoreboard players set _water_gate_fx dialog_timer 1

# 開啟音效
execute positioned -1761 10 1392 run playsound minecraft:block.beacon.activate ambient @a ~ ~ ~ 2 0.8
execute positioned -1761 10 1392 run playsound minecraft:block.end_portal.spawn ambient @a ~ ~ ~ 1 1.5
