# Animated Java 整合

---

## 基本資訊

| 項目 | 值 |
| :--- | :- |
| AJ 函數命名空間 | `animated_java:character` |
| 顯示道具 | `minecraft:white_dye` |
| 根實體標籤 | `aj.character.root` |
| 驅動資料包 | `animated` |
| 模型資源包 | `end_of_memories_resource` |

---

## 可用 Variant

- `default`
- `migale`
- `blackforge`
- `union`
- `dandebondo`
- `shliaka`
- `firegod`
- `lightgod`
- `watergod`
- `woodgod`

---

## 可用動畫

| 動畫 | 類型 | 時長 |
| :--- | :--- | :--- |
| `breath` | 循環 | ∞ |
| `animation_model_walk` | 循環 | ∞ |
| `nod` | 一次性 | ~30f |
| `shakehead` | 一次性 | — |
| `sidehead` | 一次性 | — |
| `bow` | 一次性 | — |
| `resetbow` | 一次性 | — |
| `hello` | 一次性 | — |
| `wavehand` | 一次性 | — |
| `give` | 一次性 | — |
| `kick` | 一次性 | — |
| `jump` | 一次性 | — |
| `jumpinplace` | 一次性 | — |
| `resethead` | 一次性 | — |

---

## 召喚與控制

```mcfunction
# 召喚（在指定位置、朝向）
execute positioned X Y Z rotated YAW 0 run function animated_java:character/summon {args: {variant: 'VARIANT'}}

# 取得根實體並加上自訂標籤
execute positioned X Y Z run tag @e[sort=nearest,limit=1,tag=aj.character.root,distance=..2] add MY_TAG

# 播放動畫（as 根實體）
execute as @e[tag=MY_TAG] run function animated_java:character/animations/ANIM/play

# 停止動畫
execute as @e[tag=MY_TAG] run function animated_java:character/animations/ANIM/stop

# 移除角色
execute as @e[tag=MY_TAG] run function animated_java:character/remove/this
```

---

## 在時間軸中使用

在場景的 `run.union` 軌（或其他軌）加入動畫事件：

| type | 欄位 | 說明 |
| :--- | :--- | :--- |
| `anim_play` | `tag`, `anim` | 開始播放動畫 |
| `anim_stop` | `tag`, `anim` | 停止動畫 |
| `anim_trs` | `tag`, `from`, `to` | 切換動畫（stop from → play to） |

範例：

```mcfunction
# t=0 開始待機，t=40 切換點頭，t=71 恢復待機
data modify storage dialogtest:story run.union set value [{t:0,type:"anim_play",tag:"MY_TAG",anim:"breath"},{t:40,type:"anim_trs",tag:"MY_TAG",from:"breath",to:"nod"},{t:71,type:"anim_trs",tag:"MY_TAG",from:"nod",to:"breath"}]
```

---

## cleanup 時移除角色

在場景的 `cleanup.mcfunction` 中：

```mcfunction
execute as @e[tag=MY_TAG] run function animated_java:character/remove/this
```
