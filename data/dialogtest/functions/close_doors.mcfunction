# 還原所有門（由 reset_triggers schedule 1t 後呼叫）

# 強制載入目標區塊
forceload add -1769 1517 -1729 1523
forceload add -1769 1435 -1729 1441
forceload add -1752 1558 -1746 1558

# 水靈座大門
clone -1758 26 1392 -1764 12 1392 -1752 12 1558
# 四道試煉門
clone -1755 25 1384 -1755 12 1390 -1769 12 1517
clone -1755 25 1384 -1755 12 1390 -1729 12 1517
clone -1755 25 1384 -1755 12 1390 -1729 12 1435
clone -1755 25 1384 -1755 12 1390 -1769 12 1435

# 卸載目標區塊
forceload remove -1769 1517 -1729 1523
forceload remove -1769 1435 -1729 1441
forceload remove -1752 1558 -1746 1558

tellraw @a {"text":"門已還原","color":"green"}
