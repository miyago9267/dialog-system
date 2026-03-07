# dialogtest

Minecraft 1.20.4 劇情執行系統，命名空間：`dialogtest`。

以**多軌時間軸**驅動劇情播放，類似影片剪輯軟體的多軌道結構——台詞、動畫、移動、控制各走獨立軌道，在同一個場景時鐘上各自觸發。

## 文檔

- [時間軸系統](docs/timeline.md)
- [Animated Java 整合](docs/aj.md)
- [Debug 與工具](docs/debug.md)
- [場景實作進度](docs/progress.md)

## 規格文件（SDD）

- [時間軸系統規格](docs/spec/timeline-spec.md)
- [AJ 角色規格](docs/spec/aj-spec.md)

## 工具

- `tools/update_triggers.py` — 觸發點座標集中映射更新
- `tools/migrate_to_timeline.py` — 舊版場景遷移至時間軸
- `tools/gen_function.py` — 場景函數骨架產生
- `tools/gen_localization.py` — 語言檔骨架產生

## 分支

- `main` — 時間軸系統實作前的存檔
- `feature/timeline-system` — 目前主要開發分支
