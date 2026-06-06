local conform = require("conform")
conform.setup({
    formatters_by_ft = {
        typescript = { "prettierd", "prettier", stop_after_first = true },
        typescriptreact = { "prettierd", "prettier", stop_after_first = true },
        javascript = { "prettierd", "prettier", stop_after_first = true },
        javascriptreact = { "prettierd", "prettier", stop_after_first = true },
        python = { "ruff_format" },
    },
    format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
    },
})

vim.keymap.set("n", "<leader>f", function()
    conform.format({ async = true })
end, { desc = "Format buffer" })
