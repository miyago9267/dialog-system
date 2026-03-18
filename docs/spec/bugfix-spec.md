---
title: Bugfix & Polish Spec
status: active
created: 2026-03-15
updated: 2026-03-18
---

# Bugfix & Polish Spec

## 待處理

### A10 [POLISH] 角色 skin 為舊版

- 狀態：等素材

### C2 [BUG] 第3段水神撥開變踢腳 + 卡死

- kick 保留作為 push 的 placeholder（push 動畫尚未製作）
- 卡死修正：ctrl 軌改呼叫 water3/cleanup（已修）
- **殘留**：push 動畫製作後需替換 kick

### D2 [BUG] grass2 木神朝向/動畫

- 待決策

### D4 [FEATURE] grass4 送花橋段

- act3 描述複雜：木神移動 -> 拿花 -> 花轉移至尤尼恩 -> 木神再移動 -> 看主角
- **需要確認**：要做到什麼程度？是否需要花道具實體？動作分解細節？

### E1 [BUG] light1 迷樓座標錯誤

- spec 記載正確座標為 `-1762 95 2118`
- 轉視角應改成 `-1669 141 2108 65 10`
- **需要確認**：座標是否正確？

### E2 [BUG] light1 沒有角色出現

- start.mcfunction 已有正確的 AJ 召喚指令
- **需要確認**：是觸發不了？位置看不到？還是其他問題？

---

## 動畫資訊表

| 動畫 | 幀數 | 模式 | 正確 ticks |
| :--- | :--- | :--- | :--- |
| nod | 20 | loop | 20 (1 cycle) |
| breath | 40 | loop | 持續播放 |
| bow | 100 | stop | 100 |
| sidehead | 100 | stop | 100 |
| give | 110 | stop | 110 (或截取) |
| kick | 10 | stop | 10 |
| shakehead | 30 | stop | 30 |
| wavehand | 35 | stop | 35 |
| push | - | - | 尚未製作 |

---

## 已完成（歸檔）

A1 跳過按鈕跳過下一段劇情 / A2 跳過+觸發器連鎖錯誤 / A3 角色有時不出現 /
A4 角色名稱殘留 / A5 呼吸動畫持續播放 / A6 角色名字顏色 / A7 頭上名稱改角色名 /
A8 黑色轉場 / A9 觀察者模式 / B1 火源裂洞座標 / B2 特寫鏡頭 / B3 fire1 角色行為 /
C1 鞠躬動畫不自然 / D1 木神朝向 / D3 grass3 卡死 / E3 light2 卡死 /
E4 踢腳 placeholder / E5 light3 接 light4 / F1-F3 water_gate 開門+鏡頭+摔落 /
G1 water2 試煉門 / 全域台詞間隔 100->80 / 全域動畫時長修正
