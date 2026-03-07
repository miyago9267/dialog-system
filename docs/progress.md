# 場景實作進度

> 各章節場景的觸發器、時間軸、AJ 動畫實作狀態追蹤

---

## 圖例

- 完成
- 部分：基礎已建但仍有 TODO
- 未開始

---

## Fire（火）

| 場景 | 觸發器 | 觸發方式 | 座標 | 時間軸 | AJ 動畫 | cleanup |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| fire1 | 完成 | 座標 `-2031 14 1760` | 已確認 | 完成 | 完成（union: breath/nod） | 完成 |
| fire2 | 完成 | 座標 `-2399 18 1727` | 已確認 | 完成 | 完成（firegod） | 完成 |
| fire3 | 完成 | trigger 變數 | 不適用 | 完成 | 無 | 無 |

---

## Water（水）

| 場景 | 觸發器 | 觸發方式 | 座標 | 時間軸 | AJ 動畫 | cleanup |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| water1 | 完成 | 座標 `-1749 12 1492` | 已確認 | 完成 | 無 | 無（使用 timeline/end） |
| water2 | 完成 | 座標 `-1749 12 1556` | 已確認 | 完成 | 無 | 無（使用 timeline/end） |
| water3 | 完成 | 座標 `-1749 12 1570`（需 water2 完成） | 已確認 | 完成 | 無 | 無（使用 timeline/end） |
| water4 | 完成 | trigger 變數 | 不適用 | 完成 | 無 | 無（使用 timeline/end） |

---

## Grass（木）

| 場景 | 觸發器 | 觸發方式 | 座標 | 時間軸 | AJ 動畫 | cleanup |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| grass1 | 完成 | 座標 `-1413 6 1870` | 已確認 | 完成 | 無 | 無（使用 timeline/end） |
| grass2 | 完成 | 座標（**待確認**） | **TODO** | 完成 | 無 | 無（使用 timeline/end） |
| grass3 | 完成 | 座標 `-916 6 1916` | 已確認 | 完成 | 無 | 無（使用 timeline/end） |
| grass4 | 完成 | trigger 變數（擊敗麥洛倪雅莎後） | 不適用 | 完成 | 部分（woodgod: nod -> breath，**召喚座標 TODO**） | 完成 |

---

## Light（光）

| 場景 | 觸發器 | 觸發方式 | 座標 | 時間軸 | AJ 動畫 | cleanup |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| light1 | 完成 | 座標（**待確認**） | **TODO** | 完成 | 無 | 無（使用 timeline/end） |
| light2 | 完成 | 座標（**待確認**） | **TODO** | 完成 | 無 | 無（使用 timeline/end） |
| light3 | 完成 | 座標（**待確認**） | **TODO** | 完成 | 無 | 無（使用 timeline/end） |
| light4 | 完成 | trigger 變數（擊敗光靈神後） | 不適用 | 完成 | 無 | 無（使用 timeline/end） |

---

## 待確認座標彙整

可使用 `tools/update_triggers.py` 一次更新所有座標。

| 場景 | 說明 | 目前值 |
| :--- | :--- | :--- |
| grass2 | 座標待確認 | `0 0 0` |
| grass4 | AJ 角色（woodgod）召喚座標與朝向待確認 | `0 0 0` |
| light1 | 光源迷樓地下入口 | `0 0 0` |
| light2 | 光源試煉場 | `0 0 0` |
| light3 | 盡頭戰場 | `0 0 0` |

---

## 工具

| 工具 | 路徑 | 說明 |
| :--- | :--- | :--- |
| 座標映射更新 | `tools/update_triggers.py` | 集中管理觸發座標，修改 `TRIGGER_COORDS` 後執行 `--apply` |
| 場景遷移 | `tools/migrate_to_timeline.py` | 舊版 N.mcfunction 轉時間軸格式 |
| 函數產生 | `tools/gen_function.py` | 產生場景函數骨架 |
| 翻譯產生 | `tools/gen_localization.py` | 產生語言檔骨架 |
