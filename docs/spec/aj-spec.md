# Animated Java 角色規格

> dialogtest datapack - AJ 角色定義、召喚、動畫控制與時間軸整合

---

## 1. 基本設定

| 項目 | 值 |
| :--- | :--- |
| AJ 函數命名空間 | `animated_java:character` |
| 顯示道具 | `minecraft:white_dye` |
| 根實體標籤 | `aj.character.root` |
| 驅動資料包 | `animated`（AJ 自動產生） |
| 模型資源包 | `end_of_memories_resource` |

---

## 2. Variant 列表

Variant 決定角色外觀（模型 / 材質），在召喚時指定。

| Variant 名稱 | 說明 |
| :--- | :--- |
| `default` | 預設外觀 |
| `migale` | 米格拉 |
| `blackforge` | 黑鍛 |
| `union` | 尤尼恩 |
| `dandebondo` | 丹德邦多 |
| `shliaka` | 什里亞卡 |
| `firegod` | 火神 |
| `lightgod` | 光神 |
| `watergod` | 水神 |
| `woodgod` | 木神 |

---

## 3. 動畫列表

| 動畫名稱 | 類型 | 說明 |
| :--- | :--- | :--- |
| `breath` | 循環 | 待機呼吸 |
| `animation_model_walk` | 循環 | 行走動畫 |
| `nod` | 一次性 | 點頭（約 30 幀） |
| `shakehead` | 一次性 | 搖頭 |
| `sidehead` | 一次性 | 歪頭 |
| `bow` | 一次性 | 鞠躬 |
| `resetbow` | 一次性 | 重置鞠躬姿勢 |
| `hello` | 一次性 | 打招呼 |
| `wavehand` | 一次性 | 揮手 |
| `give` | 一次性 | 給予動作 |
| `kick` | 一次性 | 踢 |
| `jump` | 一次性 | 跳躍 |
| `jumpinplace` | 一次性 | 原地跳 |
| `resethead` | 一次性 | 重置頭部姿勢 |

---

## 4. 函數 API

所有操作以 AJ 根實體（標籤 `aj.character.root`）為目標。

### 4.1 召喚

```mcfunction
execute positioned <X> <Y> <Z> rotated <YAW> 0 \
    run function animated_java:character/summon {args: {variant: '<VARIANT>'}}
```

| 參數 | 說明 |
| :--- | :--- |
| `X Y Z` | 召喚座標 |
| `YAW` | 水平朝向角度 |
| `VARIANT` | variant 名稱（見第 2 節） |

### 4.2 標記（加上自訂標籤）

召喚後立即以座標最近的根實體加上場景專用標籤：

```mcfunction
execute positioned <X> <Y> <Z> \
    run tag @e[sort=nearest,limit=1,tag=aj.character.root,distance=..2] add <MY_TAG>
```

> 後續所有操作皆透過 `<MY_TAG>` 選擇角色，避免影響其他 AJ 實體。

### 4.3 播放動畫

```mcfunction
execute as @e[tag=<MY_TAG>] run function animated_java:character/animations/<ANIM>/play
```

### 4.4 停止動畫

```mcfunction
execute as @e[tag=<MY_TAG>] run function animated_java:character/animations/<ANIM>/stop
```

### 4.5 移除角色

```mcfunction
execute as @e[tag=<MY_TAG>] run function animated_java:character/remove/this
```

---

## 5. 時間軸整合

AJ 角色動畫事件放置於場景的 **union 軌**（或其他自訂軌道）。

### 5.1 可用事件類型

| type | 必填欄位 | 說明 |
| :--- | :--- | :--- |
| `anim_play` | `tag`, `anim` | 開始播放動畫 |
| `anim_stop` | `tag`, `anim` | 停止動畫 |
| `anim_trs` | `tag`, `from`, `to` | 切換動畫（stop `from` -> play `to`） |

### 5.2 典型動畫排程模式

```text
t=0      anim_play  breath     <- 場景開始即進入待機
t=N      anim_trs   breath->X  <- 在台詞 N 時切換到動作 X
t=N+Xf   anim_trs   X->breath  <- 動作結束後恢復待機
```

範例（union 軌）：

```mcfunction
data modify storage dialogtest:story run.union set value [\
  {t:0,   type:"anim_play", tag:"union", anim:"breath"},\
  {t:240, type:"anim_trs",  tag:"union", from:"breath", to:"nod"},\
  {t:271, type:"anim_trs",  tag:"union", from:"nod",    to:"breath"}\
]
```

> **注意**：上方以反斜線換行僅為文件可讀性，實際 mcfunction 中必須寫成**單行**。

---

## 6. 場景生命週期中的 AJ 角色

### 6.1 start.mcfunction 中

1. 召喚角色（`summon`）
2. 加上自訂標籤（`tag add`）
3. 在 union 軌設定動畫事件

### 6.2 播放中

- 引擎每 tick 推進 union 軌，自動依 `t` 值派發 `anim_play` / `anim_stop` / `anim_trs`
- 如需每 tick 控制（如角色移動），改用 villager 軌的 `fn` 事件搭配持續行為 flag

### 6.3 cleanup.mcfunction 中

```mcfunction
execute as @e[tag=<MY_TAG>] run function animated_java:character/remove/this
```

### 6.4 跳過劇情時

`skip.mcfunction` 會以 `@e[tag=aj.character.root]` 一次移除所有 AJ 角色。
