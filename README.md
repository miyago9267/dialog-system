# dialogtest 劇情執行系統文檔
> Minecraft 1.20.4 · 資料包命名空間：`dialogtest`

---

## 系統概覽

劇情系統以 **章節（chapter）→ 段落（paragraph）→ 步驟（dialog）** 三層結構組織內容，每 tick 由 `dialogtest:tick` 驅動，自動按步驟執行。

```
chapter （章節）
└── paragraph （段落）            ← 一場戲
    ├── start.mcfunction          ← 開場：召喚角色、鎖定玩家、啟動播放
    ├── 0.mcfunction              ← 步驟 0（dialog = 0）
    ├── 1.mcfunction              ← 步驟 1
    └── N.mcfunction              ← 最終步驟：清理場景、結束播放
```

**現有章節：**
- `fire` — 火之章（段落：fire1, fire2, fire3）
- `palace` — 宮殿之章（段落：palace1 ~ palace5）

---

## 核心 Storage 結構

```
storage dialogtest:story
└── run
    ├── playing   : 0b | 1b   播放中旗標
    ├── cd        : int       剩餘冷卻 ticks（>0 時跳過執行本幀）
    ├── chapter   : string    當前章節名，如 "fire"
    ├── paragraph : string    當前段落名，如 "fire1"
    └── dialog    : int       當前步驟編號（對應 N.mcfunction）
```

---

## 主循環（dialogtest:tick）

每 tick 執行：
1. 呼叫各章節的 `trigger.mcfunction`（如 `fire/trigger`）偵測觸發條件
2. 若 `run.playing != 1b` → return
3. 若 `run.cd > 0` → 倒數一格後 return（等待冷卻中）
4. 冷卻結束 → 呼叫 `dialogtest:list with storage dialogtest:story run`
5. `list.mcfunction` 展開 macro：`$function dialogtest:$(chapter)/$(paragraph)/$(dialog)`
   → 即呼叫 `dialogtest:<chapter>/<paragraph>/<dialog>.mcfunction`

---

## 寫一個新段落

### 1. `start.mcfunction`（開場，由觸發器直接呼叫）

```mcfunction
# 防止重複觸發（搭配 trigger.mcfunction 使用）
scoreboard players set my_scene_triggered my_story 1

# 場景準備：鎖定玩家視角
effect give @a slowness 999999 255 true
effect give @a jump_boost 999999 128 true
effect give @a blindness 1 0 true   # 短暫遮黑轉場

# 召喚 NPC、傳送玩家等（見 AJ 整合章節）
# ...

# 啟動播放系統（必填，順序固定）
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.cd set value 1
data modify storage dialogtest:story run.chapter set value "chapter_name"
data modify storage dialogtest:story run.paragraph set value "paragraph_name"
data modify storage dialogtest:story run.dialog set value 0
```

### 2. 步驟函數（N.mcfunction）

**標準格式（字幕步驟）：**
```mcfunction
# 顯示字幕（使用 resource pack translate key）
tellraw @a {"translate": "story.chapter.paragraph.lineN"}

# 設定下一步等待時間（必填）
data modify storage dialogtest:story run.cd set value 40

# 指向下一步（必填）
data modify storage dialogtest:story run.dialog set value <N+1>
```

**帶角色名的字幕（告訴玩家是誰在說話）：**
```mcfunction
tellraw @a {"translate": "story.chapter.paragraph.lineN", "with": [{"selector": "@e[tag=PlayerName]", "color": "aqua"}]}
```

**附帶動作的步驟（如播放動畫）：**
```mcfunction
tellraw @a {"translate": "story.chapter.paragraph.lineN"}

# 播放 AJ 動畫
execute as @e[tag=MY_CHAR] run function animated_java:character/animations/nod/play

data modify storage dialogtest:story run.cd set value 40
data modify storage dialogtest:story run.dialog set value <N+1>
```

**冷卻時長參考：**
| 時長 | ticks | 使用情境 |
|------|-------|----------|
| 1 秒 | 20 | 短暫停頓 |
| 2 秒 | 40 | 標準對話行 |
| 3 秒 | 60 | 較長字幕 |
| 自訂 | 任意 | 依實際節奏調整 |

### 3. 最終步驟（段落結尾，dialog = N）

```mcfunction
# 最後一句字幕（選用）
tellraw @a {"translate": "story.chapter.paragraph.lastline"}

# 解除玩家鎖定
effect clear @a slowness
effect clear @a jump_boost

# 移除 AJ 角色與其他臨時實體
execute as @e[tag=MY_CHAR] run function animated_java:character/remove/this
kill @e[tag=scene_entities]

# 結束播放（必填）
data modify storage dialogtest:story run.playing set value 0b
data modify storage dialogtest:story run.cd set value 40
data modify storage dialogtest:story run.dialog set value 0
```

---

## 觸發器（trigger.mcfunction）

位於 `functions/<chapter>/trigger.mcfunction`，在 `tick.mcfunction` 中每 tick 呼叫。

**位置觸發（玩家走近特定座標）：**
```mcfunction
execute unless score scene1_triggered my_story matches 1 \
    positioned X Y Z if entity @a[distance=..R] \
    run function dialogtest:chapter/paragraph/start
```

**計分板旗標觸發（可由外部事件手動設定）：**
```mcfunction
# 觸發條件：scoreboard players set scene3_trigger my_story 1
execute if score scene3_trigger my_story matches 1.. \
    unless score scene3_triggered my_story matches 1 \
    run function dialogtest:chapter/paragraph/start
# 消費旗標（防止重複觸發）
execute if score scene3_trigger my_story matches 1.. \
    run scoreboard players set scene3_trigger my_story 0
```

> **Note：** 各章節使用自己的計分板，如 `fire_story`、`water_story`。

---

## Tick 背景動作

部分動作需每 tick 持續執行（如 NPC 移動、持續動畫判斷），在 `tick.mcfunction` 中加入段落判斷：

```mcfunction
execute if score _playing dialog_timer matches 1 \
    if data storage dialogtest:story {run:{chapter:"fire",paragraph:"fire1"}} \
    run function dialogtest:fire/fire1/villager_walk
```

---

## Animated Java (AJ) 整合

### 系統資訊

| 項目 | 值 |
|------|----|
| AJ 函數命名空間 | `animated_java:character` |
| 顯示道具 | `minecraft:white_dye` |
| 根實體標籤 | `aj.character.root` |
| 驅動資料包 | `animated`（世界存檔 datapacks 內） |
| 模型資源包 | `end_of_memories_resource` |

### 可用外觀（Variant）

| Variant 名稱 | 角色 |
|--------------|------|
| `default` | 預設（米加萊） |
| `migale` | 米加萊 |
| `blackforge` | 黑鍛 |
| `union` | 尤尼恩 |
| `dandebondo` | 丹德邦多 |
| `shliaka` | 絲里亞卡 |
| `firegod` | 火神 |
| `lightgod` | 光神 |
| `watergod` | 水神 |
| `woodgod` | 木神 |

### 可用動畫

| 動畫名稱 | 類型 | 時長 | 說明 |
|----------|------|------|------|
| `breath` | **循環** | ∞ | 待機呼吸（適合作為預設動畫） |
| `animation_model_walk` | **循環** | ∞ | 行走 |
| `nod` | 一次性 | ~30f | 點頭 |
| `shakehead` | 一次性 | - | 搖頭（表示否定） |
| `sidehead` | 一次性 | - | 側頭（表示疑問） |
| `bow` | 一次性 | - | 鞠躬 |
| `resetbow` | 一次性 | - | 鞠躬後回正 |
| `hello` | 一次性 | - | 打招呼揮手 |
| `wavehand` | 一次性 | - | 揮手 |
| `give` | 一次性 | - | 遞出東西 |
| `kick` | 一次性 | - | 踢腿 |
| `jump` | 一次性 | - | 跳躍 |
| `jumpinplace` | 一次性 | - | 原地跳 |
| `resethead` | 一次性 | - | 頭部姿勢回正 |

### 召喚角色

```mcfunction
# 在指定位置、朝向召喚並套用 variant 外觀
execute positioned X Y Z rotated YAW 0 run function animated_java:character/summon {args: {variant: 'VARIANT'}}

# 加上自訂標籤（便於後續控制，MY_TAG 自定義）
execute positioned X Y Z run tag @e[sort=nearest,limit=1,tag=aj.character.root,distance=..2] add MY_TAG
```

### 控制動畫（必須 as 根實體執行）

```mcfunction
# 播放動畫
execute as @e[tag=MY_TAG] run function animated_java:character/animations/ANIM_NAME/play

# 停止動畫
execute as @e[tag=MY_TAG] run function animated_java:character/animations/ANIM_NAME/stop

# 移除整個角色（含所有骨骼實體）
execute as @e[tag=MY_TAG] run function animated_java:character/remove/this
```

### 動畫組合：一次性 → 回復循環

> **重要：** 同時播放兩個動畫會衝突（都嘗試設定骨骼位置）。
> 播放新動畫前請先停止舊動畫。

**模式：** 停止待機 → 播放一次性 → 計時重啟待機
```mcfunction
# 步驟 N.mcfunction 中：
# 1. 停止待機動畫
execute as @e[tag=MY_TAG] run function animated_java:character/animations/breath/stop
# 2. 播放一次性動畫（以 nod 為例，約 30 ticks 後自動停止）
execute as @e[tag=MY_TAG] run function animated_java:character/animations/nod/play
# 3. 31 ticks 後重啟 breath
schedule function dialogtest:my_chapter/my_para/aj_resume_breath 31t

data modify storage dialogtest:story run.cd set value 40
data modify storage dialogtest:story run.dialog set value <N+1>
```

`aj_resume_breath.mcfunction`：
```mcfunction
execute as @e[tag=MY_TAG] run function animated_java:character/animations/breath/play
```

### 更換外觀（Variant）

```mcfunction
# 切換角色皮膚（在角色召喚後執行）
execute as @e[tag=MY_TAG] run function animated_java:character/variants/VARIANT/apply
```

---

## operations/aj 框架（選用）

`dialogtest:operations/aj` 提供統一的 AJ 操作介面，內部使用 macro 展開：

```mcfunction
# 召喚（action: "create"）
data modify storage dialogtest:story current set value {action:"create",args:{tag:"MY_TAG",variant:"union",x:-2029,y:13,z:1764,rot:40}}
function dialogtest:operations/aj

# 播放動畫（action: "play"）
data modify storage dialogtest:story current set value {action:"play",args:{tag:"MY_TAG",anim:"breath"}}
function dialogtest:operations/aj

# 停止動畫（action: "stop"）
data modify storage dialogtest:story current set value {action:"stop",args:{tag:"MY_TAG",anim:"breath"}}
function dialogtest:operations/aj

# 移除角色（action: "end"）
data modify storage dialogtest:story current set value {action:"end",args:{tag:"MY_TAG"}}
function dialogtest:operations/aj
```

---

## translate key 命名規範

字幕統一使用 Resource Pack 的 translate key，不在 mcfunction 中寫死文字：

```
story.<章節>.<段落>.<行號>
```

例：`story.fire.fire1.line1`、`story.palace.palace3.line7`

在 `end_of_memories_resource/assets/minecraft/lang/zh_tw.json` 中定義對應文字。

---

## 完整新段落流程（Quick Start）

1. 建立 `functions/<chapter>/<paragraph>/start.mcfunction`
2. 建立 `functions/<chapter>/<paragraph>/0.mcfunction` ~ `N.mcfunction`
3. 在 `functions/<chapter>/trigger.mcfunction` 加入觸發條件
4. 在 lang 檔新增 translate key
5. 若有 tick 背景動作，在 `functions/tick.mcfunction` 加入判斷

---

## Debug 小抄

```mcfunction
# 查看當前播放狀態
data get storage dialogtest:story run

# 手動跳到某一步
data modify storage dialogtest:story run.dialog set value 5
data modify storage dialogtest:story run.cd set value 1

# 強制結束播放
data modify storage dialogtest:story run.playing set value 0b

# 重設某段落觸發旗標（可重新觸發）
scoreboard players set fire1_triggered fire_story 0
```
