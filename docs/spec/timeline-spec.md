# 時間軸系統規格

> dialogtest datapack - Minecraft 1.20.4 多軌時間軸劇情驅動架構

---

## 1. 概述

時間軸系統以 **多軌道** 結構驅動場景劇情。每個場景由一組獨立軌道組成，各軌道持有一列 **事件**，引擎每 tick 以 `scene_tick` 遞增計時器推進，當事件的 `t` 值等於或小於當前 `scene_tick` 時依序派發執行。

```text
scene_tick: 0 ──────── 40 ──────── 80 ──── ... ──── 600
text:       [line1     ][line2     ][line3            ]...
union:      [breath                      ][nod][breath]
villager:                                      [walk  ]
ctrl:                                                  [cleanup]
```

---

## 2. Storage 結構

| 路徑 | 型別 | 說明 |
| :--- | :--- | :--- |
| `dialogtest:story run.playing` | `byte` (`0b` / `1b`) | 播放中旗標 |
| `dialogtest:story run.mode` | `string` | 模式鑑別，時間軸模式固定為 `"timeline"` |
| `dialogtest:story run.scene` | `string` | 場景 ID（如 `"fire1"`、`"fire_fire2"` 等） |
| `dialogtest:story run.scene_tick` | `int` | 場景時鐘（每 tick +1，從 0 開始） |

### 2.1 軌道陣列

場景啟動時在 storage `run` 下設定以下軌道，每條軌道為一個 **事件陣列**：

| 軌道 | storage 路徑 | 用途 | 必要性 |
| :--- | :--- | :--- | :--- |
| text | `run.text` | 台詞序列 | 必要（至少一句） |
| union | `run.union` | AJ 角色動畫控制 | 選用 |
| villager | `run.villager` | 角色移動 / 自訂行為控制 | 選用 |
| ctrl | `run.ctrl` | 場景控制（cleanup / 結束等） | 必要 |

### 2.2 內部暫存

| 路徑 | 說明 |
| :--- | :--- |
| `run._tl_args` | advance macro 的軌道路徑參數，格式 `{track:"run.text"}` |
| `run.current_event` | 當前正在處理的事件（由 advance 從軌道 pop 出） |

---

## 3. 事件格式

所有事件皆為 NBT compound，**必須** 包含 `t`（觸發時間，單位 tick）與 `type`。

### 3.1 事件類型定義

#### `text` - 純文字台詞

```nbt
{t: <int>, type: "text", key: "<translate key>"}
```

| 欄位 | 型別 | 說明 |
| :--- | :--- | :--- |
| `t` | int | 觸發 tick |
| `key` | string | 語言檔 translate key，如 `"story.fire.fire1.line3"` |

**實作**：`$tellraw @a {"translate":"$(key)"}`

#### `text_player` - 帶玩家名稱的台詞

```nbt
{t: <int>, type: "text_player", key: "<translate key>"}
```

| 欄位 | 型別 | 說明 |
| :--- | :--- | :--- |
| `t` | int | 觸發 tick |
| `key` | string | 語言檔 translate key |

**實作**：`$tellraw @a {"translate":"$(key)","with":[{"selector":"@e[tag=PlayerName]","color":"aqua"}]}`

> translate key 中的 `%s` 會被替換為標籤 `PlayerName` 的實體名稱。

#### `anim_play` - 播放 AJ 動畫

```nbt
{t: <int>, type: "anim_play", tag: "<entity tag>", anim: "<animation name>"}
```

| 欄位 | 型別 | 說明 |
| :--- | :--- | :--- |
| `t` | int | 觸發 tick |
| `tag` | string | AJ 根實體的自訂標籤 |
| `anim` | string | 動畫名稱（見 AJ spec） |

**實作**：`$execute as @e[tag=$(tag)] run function animated_java:character/animations/$(anim)/play`

#### `anim_stop` - 停止 AJ 動畫

```nbt
{t: <int>, type: "anim_stop", tag: "<entity tag>", anim: "<animation name>"}
```

欄位同 `anim_play`。

**實作**：`$execute as @e[tag=$(tag)] run function animated_java:character/animations/$(anim)/stop`

#### `anim_trs` - 動畫切換（stop + play）

```nbt
{t: <int>, type: "anim_trs", tag: "<entity tag>", from: "<old anim>", to: "<new anim>"}
```

| 欄位 | 型別 | 說明 |
| :--- | :--- | :--- |
| `t` | int | 觸發 tick |
| `tag` | string | AJ 根實體的自訂標籤 |
| `from` | string | 要停止的動畫名稱 |
| `to` | string | 要播放的新動畫名稱 |

**實作**：先 stop `from`，再 play `to`。

#### `fn` - 呼叫任意 mcfunction

```nbt
{t: <int>, type: "fn", fn: "<namespace:path/to/function>"}
```

| 欄位 | 型別 | 說明 |
| :--- | :--- | :--- |
| `t` | int | 觸發 tick |
| `fn` | string | 函數的完整命名空間路徑 |

**實作**：`$function $(fn)`

---

## 4. 時間計算參考

| 時長 | ticks |
| :--- | :---- |
| 1 秒 | 20 |
| 2 秒（標準台詞間隔） | 40 |
| 3 秒（長台詞間隔） | 60 |

台詞 N 的 `t` 值（等間隔情況下）：`(N - 1) * cd`

---

## 5. Tick 引擎流程

### 5.1 主 tick 路由

```text
tick.mcfunction
  |-- 觸發器檢查（fire/trigger, water/trigger 等，永遠執行）
  |-- if playing = 0b -> return 0（非播放中直接返回）
  |-- 跳過檢查（skip_scene trigger）
  |-- if mode = "timeline" -> operations/timeline/tick -> return 1
  \-- else -> 舊系統（N.mcfunction 模式）
```

### 5.2 timeline/tick.mcfunction

每 tick 順序執行：

1. **遞增 `_scene_tick`**，同步寫入 storage `run.scene_tick`
2. **首 tick 處理**（`_scene_tick == 1`）：啟用 `skip_scene` trigger 並顯示跳過按鈕
3. **持續行為**：依場景 flag 呼叫持續函數（如村民移動）
4. **推進各軌道**（依序 text -> union -> villager -> ctrl）：
   - 設定 `_tl_args = {track:"run.<軌道>"}`
   - 若軌道 `[0]` 存在，呼叫 `advance`

### 5.3 advance.mcfunction（macro，遞迴）

```text
1. if track[0] 不存在 -> return 0
2. if track[0].t > _scene_tick -> return 0（尚未到觸發時間）
3. pop track[0] -> run.current_event
4. dispatch_event（依 type 呼叫對應 dispatch 函數）
5. 遞迴呼叫自身（處理同一 tick 內的多個事件）
```

### 5.4 dispatch_event.mcfunction

以 `run.current_event.type` 比對，將事件轉發至 `dispatch/<type>.mcfunction`。所有 dispatch 函數均為 **macro**，以 `run.current_event` 的欄位作為 macro 參數。

---

## 6. 場景結構規範

### 6.1 目錄結構

```text
<chapter>/
  <scene>/
    start.mcfunction      <- 場景入口
    cleanup.mcfunction    <- 場景收尾
    (其他場景專用函數)
```

### 6.2 start.mcfunction 必要步驟

以下為 start.mcfunction 的標準流程，順序固定：

```mcfunction
# 1. 設置觸發旗標，防止重複執行
scoreboard players set <scene>_triggered <story_obj> 1

# 2. 場景設置（鎖定玩家、召喚實體等）
effect give @a slowness 999999 255 true

# 3. 設定各軌道資料（每條必須是單行指令）
data modify storage dialogtest:story run.text set value [...]
data modify storage dialogtest:story run.union set value [...]     # 選用
data modify storage dialogtest:story run.villager set value [...]  # 選用
data modify storage dialogtest:story run.ctrl set value [...]

# 4. 啟動時間軸
scoreboard players set _scene_tick dialog_timer 0
data modify storage dialogtest:story run.playing set value 1b
data modify storage dialogtest:story run.mode set value "timeline"
data modify storage dialogtest:story run.scene set value "<scene_id>"
data modify storage dialogtest:story run.scene_tick set value 0
```

> **限制**：`data modify ... set value [...]` 必須寫在同一行，mcfunction 不支援反斜線換行。

### 6.3 cleanup.mcfunction 必要步驟

```mcfunction
# 1. 解除玩家效果
effect clear @a slowness
effect clear @a jump_boost

# 2. 停止持續行為 flag

# 3. 清除場景實體與 AJ 角色
execute as @e[tag=<TAG>] run function animated_java:character/remove/this
kill @e[tag=<scene_tag>]

# 4. 結束時間軸
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode
```

---

## 7. 觸發器

觸發器定義在 `<chapter>/trigger.mcfunction`，由主 `tick.mcfunction` 每 tick 無條件執行。

```mcfunction
execute unless score <scene>_triggered <story_obj> matches 1 \
    if entity @a[distance=..5] \
    run function dialogtest:<chapter>/<scene>/start
```

---

## 8. 持續行為（每 tick 動作）

用於需要每 tick 更新的邏輯（如角色移動）：

1. 在 `timeline/tick.mcfunction` 中加入 flag 判斷行
2. 以 villager 軌的 `fn` 事件開關 flag
3. 在 `cleanup.mcfunction` 中關閉 flag

```text
villager 軌事件觸發 fn -> 設定 flag = 1
timeline/tick 每 tick 檢查 flag -> 執行持續函數
cleanup / 另一個 fn 事件 -> 設定 flag = 0
```

---

## 9. 跳過劇情

觸發方式：玩家點擊聊天欄中的 `[跳過劇情]` 按鈕（`/trigger skip_scene set 1`）。

流程：

1. `tick.mcfunction` 偵測 `skip_scene >= 1`
2. 呼叫 `skip.mcfunction`：
   - `flush_text`：遞迴輸出 text 軌所有剩餘台詞
   - 停止時間軸（`playing = 0b`）
   - 清除玩家效果
   - 清除所有 AJ 角色與場景實體
   - 重置持續行為 flag

---

## 10. 實作注意事項

- **Minecraft 1.20.4 限制**：不支援 inline NBT function 呼叫（如 `function foo {key:"val"}`），必須先將參數寫入 storage，再以 `function ... with storage` 呼叫 macro。
- **軌道推進順序固定**：text -> union -> villager -> ctrl，不可更改。
- **同 tick 多事件**：advance 使用遞迴處理，同一 tick 內所有 `t` 值相同的事件會連續派發。
- **首 tick 為 1**：`_scene_tick` 在啟動後的第一個 tick 從 0 加到 1，因此事件的最小 `t` 值通常設為 0（在 tick 1 時觸發）。
