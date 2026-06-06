require("copilot").setup({
    suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
            accept = "<C-l>",
            accept_word = "<C-Right>",
            next = "<C-]>",
            prev = "<C-[>",
            dismiss = "<Esc>",
        },
    },
    panel = { enabled = false },
})
