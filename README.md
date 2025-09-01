# dialogtest 對話/劇本系統（Minecraft 1.20.4）

輕量的資料驅動劇本執行器：以 storage 作為佇列（queue），每 tick 讀取第一筆步驟，依 `op` 派發對應功能，支援冷卻（`wait.ticks`）、字幕、傳送、呼叫其他指令/功能等。

## 安裝

- 將 `dialogtest` 資料包放入世界存檔的 `datapacks/`。
- 啟用後，建議在世界載入時執行一次初始化（見下）。

## 初始化

手動執行一次：

```mcfunction
/function dialogtest:init
```

作用：

- 建立計分板目標：`dialog_timer`。
- 建立第一章資料：`function dialogtest:chapter1/init`。

如需自動化，請在 `data/minecraft/tags/functions/load.json` 與 `tick.json` 中掛載 `dialogtest:init` 與 `dialogtest:tick`。

## Main Loop

由 `function dialogtest:tick` 負責：

1. 若 `run.playing != 1b` 直接 return。
2. 若 `run.cd > 0` → 倒數後 return。
3. 取隊首 `chapters.chapter1[0]` 到 `current`。
4. 依 `current.op` 派發到對應 operations 函式。
5. 若 `current.wait.ticks` 存在，將其寫入 `run.cd` 作為下一步延遲。
6. 移除隊首（左移）。

## 資料結構（storage dialogtest:story）

```json
{
    "run": { "id": "chapter1", "cd": 0, "playing": 0 },
    "chapters": {
        "chapter1": [
            { "op": "tellraw", "text": "<text_component>", "wait": { "ticks": 40 } },
            { "op": "tp", "target": "@a", "pos": [0, 100, 0] }
        ]
    },
    "current": "<由系統在 tick 時暫存的目前步驟>"
}
```

說明：

- `run.playing`: 1b 表播放中；0b 表停止。
- `run.cd`: tick 倒數；>0 時先倒數後 return。
- `chapters.chapter1`: 劇本步驟佇列（從左到右執行）。
- `current`: 每 tick 將佇列第一筆複製到此供 operations 使用。

## 支援的 op

- `tellraw`：
  - 欄位：`text`（Text Component 字串，支援 translate/with/selector 等）
  - 實作：`dialogtest:operations/tellraw`，廣播給全體玩家。
- `tp`：
  - 欄位：
    - `target`: "@a" | "@p"（省略預設 `@a`）
    - `pos`: [x,y,z]（任意座標，動態支持；以臨時 `interaction` 實體為錨點傳送）
    - `loc`: 具名地點（可自訂在 tp.mcfunction 內的對應）
- 實作：`dialogtest:operations/tp`
  - 若 `pos` 存在：
    1) 召喚臨時 `interaction`，將 `pos` 寫入其 `Pos[0..2]`。
    2) 依 `target` 將玩家傳送至該實體。
    3) 刪除臨時實體。
  - 若 `pos` 不存在而 `loc` 存在：以對應座標傳送。
- `cmd` / `aj_play` / `wait`：
  - 預留分派點，尚未實作 `data/dialogtest/functions/operations/`。

## 建立劇本

`function dialogtest:chapter1/init` 已示範三步：

1) 顯示第一句字幕並等待 40t
2) 顯示第二句字幕並等待 60t
3) 傳送全體玩家到 [x, y, z]

啟動播放：

```mcfunction
/function dialogtest:chapter1/main
```

內容：

- 將 `run.playing` 設為 1b、`run.cd` 設為 1，tick 便開始處理佇列。

## 擴充

- 文本維護：
  - 優先使用 resource pack 的 `translate` key，避免在 mcfunction 中寫長 JSON。
  - 若仍需長文本，建議拆分到獨立 function 檔僅做 set value，主腳本用 `function ...` 載入。
- 章節切換：
  - 將 `run.id` 作為章節名稱；若要切換章節，將推入的陣列改為 `chapters.<id>`，tick 內亦可依 `run.id` 讀取對應佇列（目前示例固定使用 `chapter1`）。
- 新 op：
  - 依樣在 `operations/` 下新增檔案，並在 tick 的分派區塊加入對應判斷。

## 疑難排解（Debug）

- tp 錨點：`operations/tp.mcfunction` 會在寫入 `Pos` 後以 `[TP Anchor]` 輸出座標；若沒有看到，表示 `current.pos` 可能格式不符。
- 計分板：若 `dialog_timer` 未建立，請重新執行 `function dialogtest:init`。
- 沒有播放：確認 `run.playing` 是否為 1b、佇列是否非空、`run.cd` 是否為 0。

---

作者：你可以在 `README.md` 末尾補充自己的備註、流程圖或路線規劃。
