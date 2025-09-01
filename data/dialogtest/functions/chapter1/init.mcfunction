# 寫故事的地方

## Schema
## { "op": "cmd", "target": "@a", "text": "text_object", "wait": 20 }
## op ->  Optional: "tellraw" | "tp" | "cmd" | "aj_play" | "camera" | "wait" ...
## target ->  selector("@a"|"@p[...]")
##
## if (ops == "tellraw")
### text -> Optional: "text_object"
## if (ops == "cmd")
### fn -> Optional: "function_name"
## if (ops == "tp")
### pos -> Optional: <x> <y> <z>
## if (ops == "aj_play")
### action -> Optional: "action_name"

data modify storage dialogtest:story chapters.chapter1 set value []

# # step 1
# data modify storage dialogtest:story chapters.chapter1 append value {}
# data modify storage dialogtest:story chapters.chapter1[-1].op set value "tellraw"
# data modify storage dialogtest:story chapters.chapter1[-1].text set value "{\"translate\":\"story.chapter1.line1\",\"with\":[{\"selector\":\"@p\"}]}"
# data modify storage dialogtest:story chapters.chapter1[-1].wait set value {ticks:40}

# # step 2
# data modify storage dialogtest:story chapters.chapter1 append value {}
# data modify storage dialogtest:story chapters.chapter1[-1].op set value "tellraw"
# data modify storage dialogtest:story chapters.chapter1[-1].text set value "{\"translate\":\"story.chapter1.line2\",\"with\":[{\"translate\":\"story.chapter1.line2.items\"}]}"
# data modify storage dialogtest:story chapters.chapter1[-1].wait set value {ticks:60}

# step 3
data modify storage dialogtest:story chapters.chapter1 append value {}
data modify storage dialogtest:story chapters.chapter1[-1].op set value "tp"
data modify storage dialogtest:story chapters.chapter1[-1].target set value "@a"
data modify storage dialogtest:story chapters.chapter1[-1].pos set value [-1747,83,351]

# execute status
data modify storage dialogtest:story run set value {id:"chapter1",cd:0,playing:0b}
