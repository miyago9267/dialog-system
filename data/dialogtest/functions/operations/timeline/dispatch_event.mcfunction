# 根據 run.current_event.type 派發到對應的處理函數
# 所有處理函數均為 macro，以 run.current_event 作為參數來源

execute if data storage dialogtest:story {run:{current_event:{type:"text"}}} \
    run function dialogtest:operations/timeline/dispatch/text \
    with storage dialogtest:story run.current_event

execute if data storage dialogtest:story {run:{current_event:{type:"text_player"}}} \
    run function dialogtest:operations/timeline/dispatch/text_player \
    with storage dialogtest:story run.current_event

execute if data storage dialogtest:story {run:{current_event:{type:"anim_play"}}} \
    run function dialogtest:operations/timeline/dispatch/anim_play \
    with storage dialogtest:story run.current_event

execute if data storage dialogtest:story {run:{current_event:{type:"anim_stop"}}} \
    run function dialogtest:operations/timeline/dispatch/anim_stop \
    with storage dialogtest:story run.current_event

execute if data storage dialogtest:story {run:{current_event:{type:"anim_trs"}}} \
    run function dialogtest:operations/timeline/dispatch/anim_trs \
    with storage dialogtest:story run.current_event

execute if data storage dialogtest:story {run:{current_event:{type:"fn"}}} \
    run function dialogtest:operations/timeline/dispatch/fn \
    with storage dialogtest:story run.current_event
