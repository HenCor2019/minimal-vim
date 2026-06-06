require("mini.notify").setup({
    lsp_progress = {
        enable = false,
    },
    content = {
        format = function(notif)
            return notif.msg
        end,
    },
})
