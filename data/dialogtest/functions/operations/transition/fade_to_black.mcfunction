# 淡出至黑幕（場景結束 / 跳過用）
# darkness + blindness 疊加，40t 後自動清除
effect give @a darkness 999 1 true
effect give @a blindness 999 0 true
schedule function dialogtest:operations/transition/fade_from_black 40t
