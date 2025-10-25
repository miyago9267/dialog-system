# Enqueue a child sequence to background track and start it
# Schema: current.children -> list of ops to run in bg

# ensure bg containers
execute unless data storage dialogtest:story bg run data modify storage dialogtest:story bg set value {}
execute unless data storage dialogtest:story bg.run run data modify storage dialogtest:story bg.run set value {id:"bg",cd:0,playing:0b}
execute unless data storage dialogtest:story bg.chapters run data modify storage dialogtest:story bg.chapters set value {}
execute unless data storage dialogtest:story bg.chapters.story run data modify storage dialogtest:story bg.chapters.story set value []

# wrap children into a bundle so we can append as one element
data modify storage dialogtest:story _tmp_bundle set value {op:"bundle"}
data modify storage dialogtest:story _tmp_bundle.list set from storage dialogtest:story current.children
data modify storage dialogtest:story bg.chapters.story append from storage dialogtest:story _tmp_bundle
data remove storage dialogtest:story _tmp_bundle

# mark bg as playing
data modify storage dialogtest:story bg.run.playing set value 1b
