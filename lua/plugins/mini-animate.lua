local MiniAnimate = require("mini.animate")
MiniAnimate.setup({
    cursor = {
        enable = false,
    },
    scroll = {
        enable = true,
        timing = MiniAnimate.gen_timing.linear({ duration = 15, unit = "step" }),
    },
    resize = { enable = true },
    open = { enable = false },
    close = { enable = false },
})
