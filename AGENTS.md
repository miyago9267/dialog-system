# dialogtest 專案核心準則

> 本文件為 AI Agent 協作開發的最高層級指引。所有對本專案的修改與產出皆須遵守以下規則。

---

## 最高優先原則：以 SDD 為準

**Software Design Document（SDD）** 位於 `docs/spec/` 目錄下，是本專案的唯一規格真相來源。

1. **任何開發行為前，必須先閱讀相關 SDD。**
2. 若 SDD 與其他文件（docs 操作文件、README、程式碼註解）存在衝突，**以 SDD 為準**。
3. 不得在未參照 SDD 的情況下新增功能、修改架構或變更事件格式。
4. 若 SDD 未涵蓋某項需求，須先更新 SDD 再進行實作。

---

## 文件層級

依優先順序由高到低：

| 層級 | 路徑 | 說明 |
| :--- | :--- | :--- |
| 1 - SDD（規格） | `docs/spec/*.md` | 系統架構與格式的正式規格，最高權威 |
| 2 - 操作文件 | `docs/*.md` | 用法指南、範例、debug 技巧，輔助參考 |
| 3 - README | `README.md` | 專案概述與入口 |
| 4 - 程式碼註解 | `data/` 內 `.mcfunction` | 行內說明，僅作為實作細節參考 |

---

## SDD 清單

| 文件 | 涵蓋範圍 |
| :--- | :--- |
| [timeline-spec.md](docs/spec/timeline-spec.md) | 多軌時間軸系統：storage 結構、事件格式、tick 引擎、場景結構規範 |
| [aj-spec.md](docs/spec/aj-spec.md) | Animated Java 角色：variant、動畫列表、函數 API、時間軸整合 |

---

## 開發準則

### 進入任務前

1. 閱讀本文件（`AGENTS.md`）
2. 依據任務性質，閱讀對應的 SDD
3. 如有需要，參考 `docs/` 下的操作文件取得範例與 debug 方法

### 新增 / 修改場景

1. 閱讀 `docs/spec/timeline-spec.md` 第 6 節「場景結構規範」
2. 遵循 `start.mcfunction` 與 `cleanup.mcfunction` 的標準步驟順序
3. 所有事件欄位與類型必須符合 SDD 第 3 節的定義
4. 若場景使用 AJ 角色，同時參照 `docs/spec/aj-spec.md`

### 新增事件類型

1. 先在 `docs/spec/timeline-spec.md` 第 3 節新增事件定義
2. 實作對應的 `dispatch/<type>.mcfunction`
3. 在 `dispatch_event.mcfunction` 中加入路由
4. 更新操作文件 `docs/timeline.md`

### 新增 AJ Variant / 動畫

1. 先在 `docs/spec/aj-spec.md` 第 2 或第 3 節新增項目
2. 在 AJ Blueprint 中建立對應資源
3. 更新操作文件 `docs/aj.md`

### 程式碼風格

- mcfunction 不支援反斜線換行，`data modify ... set value [...]` 必須寫在**同一行**
- 所有 macro 函數以 `$` 前綴標記參數化行
- 1.20.4 不支援 inline NBT function，參數須先寫入 storage 再以 `with storage` 傳遞
- 註解使用繁體中文
- 函數路徑遵循 `<chapter>/<scene>/<action>.mcfunction` 結構

---

## 禁止事項

- 不得在未閱讀 SDD 的情況下修改時間軸引擎（`operations/timeline/` 下的檔案）
- 不得自行發明事件類型而不先更新 SDD
- 不得假設或推測 SDD 未記載的行為
- 不得修改 AJ 自動產生的 `animated` 資料包內容
