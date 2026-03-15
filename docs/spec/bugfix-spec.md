---
title: Bugfix & Polish Spec
status: active
created: 2026-03-15
updated: 2026-03-16
---

# Bugfix & Polish Spec

源自 todolist.md，按區域與優先順序整理。

## 分類說明

- **BUG**: 功能壞掉，需要修
- **POLISH**: 功能正常但體驗不佳
- **FEATURE**: 新功能

---

## A. 綜合 (Global)

### A1 [BUG] 跳過按鈕會跳過下一段劇情 ✅
- 修正：main tick.mcfunction 在非播放時清除殘留 skip_scene 分數

### A2 [BUG] 跳過+觸發器連鎖錯誤 ✅
- 修正：同 A1

### A3 [BUG] 角色有時不出現 ✅
- 修正：cleanup 正確移除 AJ 角色和 text_display

### A4 [BUG] 劇情結束後角色名稱殘留 ✅
- 修正：skip.mcfunction 加入 `kill @e[type=text_display]`

### A5 [POLISH] 呼吸動畫應持續播放 ✅
- 修正：tick.mcfunction tick 25 自動對所有 AJ 角色播放 breath

### A6 [POLISH] 角色名字顏色 ✅
- 修正：四神照區域顏色，NPC/尤尼恩白色

### A7 [POLISH] 頭上名稱改為角色名稱 ✅

### A8 [POLISH] 黑色轉場 ✅
- 修正：共通 fade_to_black/fade_from_black（darkness+blindness）

### A9 [POLISH] 玩家視角改用觀察者模式 ✅
- 修正：spectator + scene_camera marker 每 tick 鎖定

### A10 [POLISH] 角色 skin 為舊版 ⏳
- 狀態：等素材

---

## B. 火區 (Fire)

### B1 [BUG] 火源裂洞座標是舊版 ✅
- 修正：角色座標、觸發點全部更新

### B2 [FEATURE] 特寫鏡頭 ✅
- 修正：line4 特寫賽克 + line5 回復（scene_camera tp）

### B3 [BUG] fire1 角色行為 ✅
- Union 在 line6 轉向玩家（同步說話）
- 賽克在 line7 點頭（村民 pitch 控制）
- 村民走路路線改走 Union 與玩家中間
- 跳過時村民先 tp 地底再 kill

---

## C. 水區 (Water)

### C1 [BUG] 第1段鞠躬動畫不自然 ✅
- 修正：bow 動畫時長 30→100 ticks（完整播放 100 幀）

### C2 [BUG] 第3段水神撥開變踢腳 + 卡死 ✅
- kick 保留作為 push 的 placeholder（push 動畫尚未製作）
- 卡死修正：ctrl 軌改呼叫 water3/cleanup

---

## D. 木區 (Grass)

### D1 [BUG] 第1段木神朝向/動畫 🔴 待決策
- 問題：木神應看向南側花朵點頭，目前朝向不對
- **需要確認**：木神應該面朝哪個方向？花朵的確切座標？

### D2 [BUG] 第2段同上 🔴 待決策

### D3 [BUG] 第3段播完卡死 ✅
- 修正：ctrl 軌改呼叫 grass3/cleanup

### D4 [FEATURE] 第4段送花橋段 🔴 待決策
- act3 描述複雜：木神移動→拿花→花轉移至尤尼恩→木神再移動→看主角
- **需要確認**：要做到什麼程度？是否需要花道具實體？動作分解細節？

---

## E. 光區 (Light)

### E1 [BUG] 第1段迷樓座標錯誤 🔴 待決策
- spec 記載正確座標為 `-1762 95 2118`
- 轉視角應改成 `-1669 141 2108 65 10`
- **需要確認**：這些座標是否正確？目前 act5 看向 `-1775 82 2112`、act6 看向 `-1775 166 2154`

### E2 [BUG] 第1段沒有角色出現 🔴 待決策
- light1/start.mcfunction 已有正確的 AJ 召喚指令
- **需要確認**：是觸發不了？位置看不到？還是其他問題？

### E3 [BUG] 第2段播完卡死 ✅
- 修正：ctrl 軌改呼叫 light2/cleanup

### E4 [BUG] 第3段撥開變踢腳 ✅
- kick 保留作為 push 的 placeholder（同 C2）

### E5 [BUG] 第3段播完直接接第4段 ✅
- 原因：light3 text 軌包含 line7-14（與 light4 line1-8 重複）
- 修正：移除 light3 的 line7-14 及對應 action 事件，ctrl 軌從 t=1425 縮到 t=625

---

## 全域修正（跨場景）

### 台詞間隔調整 ✅
- 全場景 text 軌間隔 60→100 ticks（3秒→5秒）
- action/ctrl/villager 軌時間同步縮放
- 工具：`tools/rescale_timing.py`

### 動畫時長修正 ✅
- nod 全場景 30→20 ticks（11 處，8 檔）
- water4 bow 30→100 ticks
- 工具：`tools/fix_anim_duration.py`

### 動畫資訊表

| 動畫 | 幀數 | 模式 | 正確 ticks |
|------|------|------|------------|
| nod | 20 | loop | 20 (1 cycle) |
| breath | 40 | loop | 持續播放 |
| bow | 100 | stop | 100 |
| sidehead | 100 | stop | 100 |
| give | 110 | stop | 110 (或截取) |
| kick | 10 | stop | 10 |
| shakehead | 30 | stop | 30 |
| wavehand | 35 | stop | 35 |
| push | - | - | 尚未製作 |
