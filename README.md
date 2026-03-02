# dialogtest 劇情執行系統文檔
> Minecraft 1.20.4 · 資料包命名空間：`dialogtest`
> 分支：`feature/timeline-system`（主要開發分支）

---

## 系統概覽

劇情系統以 **多軌時間軸** 驅動，類似影片剪輯軟體的多軌道結構。

每個場景（paragraph）有多條獨立軌道，各自在 `scene_tick` 時間軸上觸發事件：

```
scene_tick: 0 ──────── 40 ──────── 80 ──────── 240 ─────── 360 ──── 600
text:       [line1     ][line2     ][line3     ][line7     ][line10  ]...
union:      [breath                            ][nod  ][breath       ]
villager:                                               [walk→dest1  ]
ctrl:                                                               [cleanup]
```

### 場景目錄結構

```
chapter/
└── scene/
    ├── start.mcfunction    ← 場景入口：載入時間軸資料、啟動播放
    └── cleanup.mcfunction  ← 場景收尾（ctrl 軌觸發，視需要建立）
```

**所有場景均已遷移至時間軸架構。** 舊版的 `N.mcfunction` 逐步分派已完全廢棄。

---

## 核心 Storage 結構

```
storage dialogtest:story run {
  playing:    0b | 1b      播放中旗標
  mode:       "timeline"   模式鑑別
  scene:      string       場景 ID（如 "fire_fire1"）
  scene_tick: int          場景時鐘（每 tick +1）

  text:    [...events]     台詞軌
  union:   [...events]     AJ 角色動畫軌（選用）
  villager:[...events]     角色移動控制軌（選用）
  ctrl:    [...events]     場景控制軌（cleanup 等）

  _tl_args:      {track:"run.text"}  advance macro 暫存參數
  current_event: {...}               當前事件（暫存）
}
```

---

## 事件格式

| type | 必填欄位 | 說明 |
|------|----------|------|
| `text` | `key` | 純文字台詞 |
| `text_player` | `key` | 帶玩家名稱的台詞（with @e[tag=PlayerName]） |
| `anim_play` | `tag`, `anim` | 播放 AJ 動畫 |
| `anim_stop` | `tag`, `anim` | 停止 AJ 動畫 |
| `anim_trs` | `tag`, `from`, `to` | 動畫切換（stop→play） |
| `fn` | `fn` | 呼叫任意 mcfunction（複雜步驟用） |

所有事件必須包含 `t` 欄位（在 `scene_tick` 時間軸上的觸發時間）。

---

## 主循環（tick.mcfunction）

```
tick.mcfunction
├── fire/trigger, water/trigger ...（觸發器，永遠執行）
├── if playing = 0b → return 0
├── if mode = "timeline" → operations/timeline/tick → return 1
└── else（舊系統保留路徑，目前無場景使用）
```

### operations/timeline/tick.mcfunction

```
每 tick：
1. _scene_tick + 1
2. 持續行為判斷（如 fire1 村民移動）
3. 推進各軌道：
   _tl_args = {track:"run.text"}    → advance
   _tl_args = {track:"run.union"}   → advance
   _tl_args = {track:"run.villager"} → advance
   _tl_args = {track:"run.ctrl"}    → advance
```

---

## 寫一個新場景

### 1. `start.mcfunction`

```mcfunction
# 防止重複觸發
scoreboard players set my_scene_triggered my_story 1

# 場景設置（鎖定玩家、召喚實體等）
effect give @a slowness 999999 255 true
tp @a X Y Z

# ⚠ 時間軸資料必須寫在「單行」，mcfunction 不支援反斜線換行！
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.ch.sc.line1"},{t:40,type:"text",key:"story.ch.sc.line2"}]

# ctrl 軌：最後一行後 40t 結束（或呼叫自訂 cleanup）
data modify storage dialogtest:story run.ctrl set value [{t:80,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# 啟動
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "ch_sc"
data modify storage dialogtest:story run.scene_tick set value 0
```

### 2. 時間計算

| 時長 | ticks |
|------|-------|
| 1 秒 | 20 |
| 2 秒（標準台詞） | 40 |
| 3 秒（長台詞） | 60 |

台詞 N 的 `t` 值 = `(N-1) × cd`（所有 cd=40 時依此推算）

### 3. 加入動畫軸

```mcfunction
# union 軌：t=0 待機，t=40 點頭，t=71 恢復
data modify storage dialogtest:story run.union set value [{t:0,type:"anim_play",tag:"union",anim:"breath"},{t:40,type:"anim_trs",tag:"union",from:"breath",to:"nod"},{t:71,type:"anim_trs",tag:"union",from:"nod",to:"breath"}]
```

### 4. 使用 `fn` 處理複雜步驟

```mcfunction
data modify storage dialogtest:story run.villager set value [{t:80,type:"fn",fn:"dialogtest:chapter/scene/custom_action"}]
```

---

## 觸發器（trigger.mcfunction）

```mcfunction
# 位置觸發（不變）
execute unless score scene1_triggered my_story matches 1 \
    positioned X Y Z if entity @a[distance=..R] \
    run function dialogtest:chapter/scene/start
```

觸發器直接呼叫 `start.mcfunction`，無需修改觸發邏輯。

---

## Animated Java (AJ) 整合

| 項目 | 值 |
|------|----|
| AJ 函數命名空間 | `animated_java:character` |
| 顯示道具 | `minecraft:white_dye` |
| 根實體標籤 | `aj.character.root` |
| 驅動資料包 | `animated` |
| 模型資源包 | `end_of_memories_resource` |

### 可用 Variant

`default` `migale` `blackforge` `union` `dandebondo` `shliaka` `firegod` `lightgod` `watergod` `woodgod`

### 可用動畫

| 動畫 | 類型 | 時長 |
|------|------|------|
| `breath` | 循環 | ∞ |
| `animation_model_walk` | 循環 | ∞ |
| `nod` | 一次性 | ~30f |
| `shakehead` / `sidehead` | 一次性 | - |
| `bow` / `resetbow` | 一次性 | - |
| `hello` / `wavehand` | 一次性 | - |
| `give` / `kick` / `jump` / `jumpinplace` | 一次性 | - |
| `resethead` | 一次性 | - |

### 召喚與控制

```mcfunction
# 召喚
execute positioned X Y Z rotated YAW 0 run function animated_java:character/summon {args: {variant: 'VARIANT'}}
execute positioned X Y Z run tag @e[sort=nearest,limit=1,tag=aj.character.root,distance=..2] add MY_TAG

# 動畫控制（as 根實體）
execute as @e[tag=MY_TAG] run function animated_java:character/animations/ANIM/play
execute as @e[tag=MY_TAG] run function animated_java:character/animations/ANIM/stop

# 移除
execute as @e[tag=MY_TAG] run function animated_java:character/remove/this
```

---

## 持續行為（每 tick 動作）

用於角色移動等需要每 tick 更新的動作：

1. `operations/timeline/tick.mcfunction` 中加入 flag 判斷：

```mcfunction
execute if score _my_flag dialog_timer matches 1 run function dialogtest:chapter/scene/my_continuous_action
```

2. 用 villager 軌的 `fn` 事件開關 flag。

3. `cleanup.mcfunction` 中關閉 flag。

參考範例：`fire/fire1/` 的村民移動實作。

---

## Debug 小抄

```mcfunction
# 查看當前時間軸狀態
data get storage dialogtest:story run

# 強制結束場景
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode

# 重設觸發旗標（可重新觸發）
scoreboard players set fire1_triggered fire_story 0

# 查看場景時鐘
scoreboard players get _scene_tick dialog_timer
```

---

## 遷移工具

`migrate_to_timeline.py`（datapacks 根目錄）可批次將舊版 N.mcfunction 場景轉換：

```bash
python migrate_to_timeline.py --dry-run  # 預覽
python migrate_to_timeline.py            # 執行
```
