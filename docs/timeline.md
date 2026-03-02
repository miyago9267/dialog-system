# 時間軸系統

多軌時間軸劇情驅動架構，Minecraft 1.20.4。

---

## 概念

類似影片剪輯軟體的多軌道結構。每個場景有多條獨立軌道，各自在 `scene_tick` 時間軸上觸發事件：

```text
scene_tick: 0 ──────── 40 ──────── 80 ──────── 240 ─────── 360 ──── 600
text:       [line1     ][line2     ][line3     ][line7     ][line10  ]...
union:      [breath                            ][nod  ][breath       ]
villager:                                               [walk→dest1  ]
ctrl:                                                               [cleanup]
```

---

## Storage 結構

```text
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

所有事件都必須包含 `t` 欄位（在 `scene_tick` 上的觸發時間）。

| type | 必填欄位 | 說明 |
| :--- | :------- | :--- |
| `text` | `key` | 純文字台詞 |
| `text_player` | `key` | 帶玩家名稱的台詞 |
| `anim_play` | `tag`, `anim` | 播放 AJ 動畫 |
| `anim_stop` | `tag`, `anim` | 停止 AJ 動畫 |
| `anim_trs` | `tag`, `from`, `to` | 動畫切換（stop → play） |
| `fn` | `fn` | 呼叫任意 mcfunction |

---

## 時間計算

| 時長 | ticks |
| :--- | :---- |
| 1 秒 | 20 |
| 2 秒（標準台詞） | 40 |
| 3 秒（長台詞） | 60 |

台詞 N 的 `t` 值 = `(N-1) × cd`（cd 全為 40 時依此推算）

---

## 寫一個新場景

### 場景目錄結構

```text
chapter/
└── scene/
    ├── start.mcfunction    ← 場景入口
    └── cleanup.mcfunction  ← 場景收尾（ctrl 軌觸發）
```

### start.mcfunction 範本

> **注意**：`data modify ... set value [...]` 必須寫在**同一行**，mcfunction 不支援反斜線換行。

```mcfunction
# 防止重複觸發
scoreboard players set my_scene_triggered my_story 1

# 場景設置（鎖定玩家、召喚實體等）
effect give @a slowness 999999 255 true
tp @a X Y Z

# 台詞軌（整行，不可換行）
data modify storage dialogtest:story run.text set value [{t:0,type:"text",key:"story.ch.sc.line1"},{t:40,type:"text",key:"story.ch.sc.line2"}]

# ctrl 軌：最後一行後 40t 結束
data modify storage dialogtest:story run.ctrl set value [{t:80,type:"fn",fn:"dialogtest:operations/timeline/end"}]

# 啟動
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "ch_sc"
data modify storage dialogtest:story run.scene_tick set value 0
```

### 加入動畫軌

```mcfunction
# union 軌：t=0 待機，t=40 點頭，t=71 恢復
data modify storage dialogtest:story run.union set value [{t:0,type:"anim_play",tag:"union",anim:"breath"},{t:40,type:"anim_trs",tag:"union",from:"breath",to:"nod"},{t:71,type:"anim_trs",tag:"union",from:"nod",to:"breath"}]
```

### 使用 fn 處理複雜步驟

```mcfunction
data modify storage dialogtest:story run.villager set value [{t:80,type:"fn",fn:"dialogtest:chapter/scene/custom_action"}]
```

---

## 觸發器

觸發器直接呼叫 `start.mcfunction`，寫法不受時間軸影響：

```mcfunction
execute unless score scene1_triggered my_story matches 1 if entity @a[distance=..5] run function dialogtest:chapter/scene/start
```

---

## 持續行為（每 tick 動作）

用於角色移動等需要每 tick 更新的動作。

1. 在 `operations/timeline/tick.mcfunction` 中加入 flag 判斷：

```mcfunction
execute if score _my_flag dialog_timer matches 1 run function dialogtest:chapter/scene/my_continuous_action
```

2. 用 villager 軌的 `fn` 事件開關 flag。

3. 在 `cleanup.mcfunction` 中關閉 flag。

參考範例：`fire/fire1/` 的村民移動實作。

---

## Tick 路由架構

```text
tick.mcfunction
├── fire/trigger, water/trigger（永遠執行）
├── if playing = 0b → return 0
├── if mode = "timeline" → operations/timeline/tick → return 1
└── else（舊系統，目前無場景使用）
```

`operations/timeline/tick.mcfunction` 每 tick：

1. `_scene_tick + 1`
2. 持續行為 flag 判斷
3. 依序推進各軌道（text → union → villager → ctrl）

### advance.mcfunction 運作原理

```text
1. if track[0] 不存在 → return
2. if track[0].t > _scene_tick → return（尚未到觸發時間）
3. pop track[0] → run.current_event
4. dispatch_event（依 type 呼叫對應 macro）
5. 遞迴（處理同一 tick 內的多個事件）
```

> **實作注意**：1.20.4 不支援 inline NBT `function foo {key:"val"}`，
> 必須先 `data modify storage ... _tl_args set value {track:"run.text"}`，
> 再 `function ... with storage dialogtest:story _tl_args`。
