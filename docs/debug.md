# Debug 與工具

---

## 遊戲內 Debug 小抄

```mcfunction
# 查看當前時間軸完整狀態
data get storage dialogtest:story run

# 查看場景時鐘
scoreboard players get _scene_tick dialog_timer

# 強制結束場景
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode

# 重設觸發旗標（允許重新觸發）
scoreboard players set fire1_triggered fire_story 0

# 重設村民移動 flag（fire1）
scoreboard players set _fire1_villager_walking dialog_timer 0
```

---

## 遷移工具

`tools/migrate_to_timeline.py` 可批次將舊版 N.mcfunction 場景轉換為時間軸格式。

```bash
# 預覽（不寫入）
python tools/migrate_to_timeline.py --dry-run

# 正式執行
python tools/migrate_to_timeline.py
```

功能：

- 自動偵測所有含編號步驟的場景目錄
- 提取 translate key、cd 值、PlayerName 判斷
- 生成新的 `start.mcfunction`（保留原有場景設置，替換 `run.*` 設定）
- 刪除舊的 `N.mcfunction` 檔案

如需跳過已手動遷移的場景，在腳本中設定 `SKIP`：

```python
SKIP = {"fire/fire1"}
```

---

## 常見問題

### 場景沒有觸發

確認觸發旗標未被設為 1：

```mcfunction
scoreboard players get fire1_triggered fire_story
```

### 場景卡住不結束

強制清除：

```mcfunction
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode
```

### AJ 角色卡住

手動移除（替換 MY\_TAG 為實際標籤）：

```mcfunction
execute as @e[tag=MY_TAG] run function animated_java:character/remove/this
```
