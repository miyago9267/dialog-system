# animated java operation
# Schema:
# - storage dialogtest:story current.action -> "create" | "play" | "stop" | "end"
# - storage dialogtest:story current.args:
#   create: {tag: "entity_tag", variant: "variant_name", x: ..., y: ..., z: ..., rot: ...}
#   play:   {tag: "entity_tag", anim: "animation_name"}
#   stop:   {tag: "entity_tag", anim: "animation_name"}
#   end:    {tag: "entity_tag"}
#
# Available variants: default, migale, blackforge, union, dandebondo, shliaka, firegod, lightgod, watergod, woodgod
# Available anims: animation_model_walk, bow, breath, give, hello, jump, jumpinplace, kick, nod, resetbow, resethead, shakehead, sidehead, wavehand

execute if data storage dialogtest:story {current:{action:"create"}} run function dialogtest:operations/aj/create with storage dialogtest:story current.args
execute if data storage dialogtest:story {current:{action:"play"}} run function dialogtest:operations/aj/start with storage dialogtest:story current.args
execute if data storage dialogtest:story {current:{action:"stop"}} run function dialogtest:operations/aj/stop with storage dialogtest:story current.args
execute if data storage dialogtest:story {current:{action:"end"}} run function dialogtest:operations/aj/end with storage dialogtest:story current.args
