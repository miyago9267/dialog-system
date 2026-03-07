# fire2 持續特效（每 tick 呼叫）
# 由 timeline/tick.mcfunction 在 scene="fire_fire2" 時驅動

# ── 火柱生成（每 20t 一道，順時針 8 點） ──────────────────────

execute if score _scene_tick dialog_timer matches 40..40 run summon minecraft:area_effect_cloud -2392 18 1727 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar"]}
execute if score _scene_tick dialog_timer matches 40..40 run summon minecraft:area_effect_cloud -2392 18 1727 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar2"]}
execute if score _scene_tick dialog_timer matches 40..40 run execute at @a run playsound minecraft:item.firecharge.use ambient @a ^ ^ ^

execute if score _scene_tick dialog_timer matches 60..60 run summon minecraft:area_effect_cloud -2390 18 1723 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar"]}
execute if score _scene_tick dialog_timer matches 60..60 run summon minecraft:area_effect_cloud -2390 18 1723 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar2"]}
execute if score _scene_tick dialog_timer matches 60..60 run execute at @a run playsound minecraft:item.firecharge.use ambient @a ^ ^ ^

execute if score _scene_tick dialog_timer matches 80..80 run summon minecraft:area_effect_cloud -2386 18 1721 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar"]}
execute if score _scene_tick dialog_timer matches 80..80 run summon minecraft:area_effect_cloud -2386 18 1721 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar2"]}
execute if score _scene_tick dialog_timer matches 80..80 run execute at @a run playsound minecraft:item.firecharge.use ambient @a ^ ^ ^

execute if score _scene_tick dialog_timer matches 100..100 run summon minecraft:area_effect_cloud -2382 18 1723 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar"]}
execute if score _scene_tick dialog_timer matches 100..100 run summon minecraft:area_effect_cloud -2382 18 1723 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar2"]}
execute if score _scene_tick dialog_timer matches 100..100 run execute at @a run playsound minecraft:item.firecharge.use ambient @a ^ ^ ^

execute if score _scene_tick dialog_timer matches 120..120 run summon minecraft:area_effect_cloud -2380 18 1727 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar"]}
execute if score _scene_tick dialog_timer matches 120..120 run summon minecraft:area_effect_cloud -2380 18 1727 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar2"]}
execute if score _scene_tick dialog_timer matches 120..120 run execute at @a run playsound minecraft:item.firecharge.use ambient @a ^ ^ ^

execute if score _scene_tick dialog_timer matches 140..140 run summon minecraft:area_effect_cloud -2382 18 1731 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar"]}
execute if score _scene_tick dialog_timer matches 140..140 run summon minecraft:area_effect_cloud -2382 18 1731 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar2"]}
execute if score _scene_tick dialog_timer matches 140..140 run execute at @a run playsound minecraft:item.firecharge.use ambient @a ^ ^ ^

execute if score _scene_tick dialog_timer matches 160..160 run summon minecraft:area_effect_cloud -2386 18 1733 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar"]}
execute if score _scene_tick dialog_timer matches 160..160 run summon minecraft:area_effect_cloud -2386 18 1733 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar2"]}
execute if score _scene_tick dialog_timer matches 160..160 run execute at @a run playsound minecraft:item.firecharge.use ambient @a ^ ^ ^

execute if score _scene_tick dialog_timer matches 180..180 run summon minecraft:area_effect_cloud -2390 18 1731 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar"]}
execute if score _scene_tick dialog_timer matches 180..180 run summon minecraft:area_effect_cloud -2390 18 1731 {Duration:600,Radius:1f,Particle:"block air",Tags:["fire2_pillar2"]}
execute if score _scene_tick dialog_timer matches 180..180 run execute at @a run playsound minecraft:item.firecharge.use ambient @a ^ ^ ^

# ── 火柱旋轉 + 火焰粒子（火柱存在期間持續執行） ────────────
execute as @e[tag=fire2_pillar] at @s run tp @s ~ ~ ~ ~30 ~
execute as @e[tag=fire2_pillar2] at @s run tp @s ~ ~ ~ ~-30 ~

execute at @e[tag=fire2_pillar] run particle flame ^-0.5 ^0 ^ 0 5 0 0.1 0 force
execute at @e[tag=fire2_pillar] run particle flame ^0.5 ^0 ^ 0 5 0 0.1 0 force

execute at @e[tag=fire2_pillar2] run particle flame ^-0.5 ^1.7 ^0 0 3 0 0.1 0 force
execute at @e[tag=fire2_pillar2] run particle flame ^0.5 ^1.7 ^0 0 3 0 0.1 0 force

# ── 中央火焰匯聚（t=240~290） ────────────────────────────────
execute if score _scene_tick dialog_timer matches 240..290 run particle minecraft:flame -2385 18 1726 0.2 3 0.2 0.02 40
execute if score _scene_tick dialog_timer matches 240..290 run particle minecraft:flame -2384 18 1727 0.2 3 0.2 0.02 40
execute if score _scene_tick dialog_timer matches 240..290 run particle minecraft:flame -2385 18 1728 0.2 3 0.2 0.02 40
execute if score _scene_tick dialog_timer matches 240..290 run particle minecraft:flame -2386 18 1727 0.2 3 0.2 0.02 40
execute if score _scene_tick dialog_timer matches 240..240 run execute at @a run playsound minecraft:item.firecharge.use ambient @a ^ ^ ^ 10 0.3

# ── 爆炸火焰粒子（t=295~315） ─────────────────────────────────
execute if score _scene_tick dialog_timer matches 295..315 run particle minecraft:flame -2385 18 1727 0 0 0 1 40

# ── 火靈神轉身（t=430~449，每 tick 旋轉 9°） ──────────────────
execute if score _scene_tick dialog_timer matches 430..449 run execute as @e[tag=firegod] at @s run tp @s ~ ~ ~ ~9 ~

# ── 玩家位置鎖定（特效期間 + 火靈神出場） ─────────────────────
execute if score _scene_tick dialog_timer matches 1..350 run tp @a -2400 18 1724
