# Debug 小抄

---

## 時間軸狀態

```mcfunction
# 查看當前時間軸完整狀態
data get storage dialogtest:story run

# 查看場景時鐘
scoreboard players get _scene_tick dialog_timer

# 強制結束場景
data modify storage dialogtest:story run.playing set value 0b
data remove storage dialogtest:story run.mode
```

---

## 觸發器重設

```mcfunction
# 重設觸發旗標（允許重新觸發）
scoreboard players set fire1_triggered fire_story 0

# 重設村民移動 flag（fire1）
scoreboard players set _fire1_villager_walking dialog_timer 0
```

---

## AJ 角色

```mcfunction
# 手動移除（替換 MY_TAG 為實際標籤）
execute as @e[tag=MY_TAG] run function animated_java:character/remove/this
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

```mcfunction
execute as @e[tag=MY_TAG] run function animated_java:character/remove/this
```
