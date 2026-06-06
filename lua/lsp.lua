require("mason").setup()

require("mason-tool-installer").setup({
    ensure_installed = {
        -- LSP
        "lua-language-server",
        "marksman",
        "gopls",
        "rust-analyzer",
        "typescript-language-server",
        "pyright",
        -- Formatters / linters
        "prettierd",
        "ruff",
        -- Debug adapters (DAP)
        "delve",            -- Go
        "debugpy",          -- Python
        "js-debug-adapter", -- Node / NestJS
    },
    run_on_start = true,
})

vim.keymap.set("n", "<C-]>", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })
vim.keymap.set("n", "df", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
vim.keymap.set("n", "vrn", vim.lsp.buf.rename, { desc = "LSP rename symbol" })

-- Al elegir una entrada del quickfix (p. ej. referencias) saltar y cerrar la lista
vim.api.nvim_create_autocmd("FileType", {
    pattern = "qf",
    callback = function()
        vim.keymap.set("n", "<CR>", "<CR>:cclose<CR>", { buffer = true, silent = true, desc = "Jump and close quickfix" })
    end,
})

vim.diagnostic.config({ virtual_text = true })

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = vim.tbl_deep_extend("force", capabilities, require("mini.completion").get_lsp_capabilities())

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("lua_ls", {
    settings = {
        Lua = {
            diagnostics = { globals = { "vim" } },
        },
    },
})

vim.lsp.enable({
    "lua_ls",
    "marksman",
    "gopls",
    "rust_analyzer",
    "ts_ls",
    "pyright",
})
