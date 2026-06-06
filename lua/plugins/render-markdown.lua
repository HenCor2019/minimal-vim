require("render-markdown").setup({
    -- Renderiza en modo normal/insertar/comando; oculta el formato en visual para editar
    render_modes = { "n", "c", "t" },
    completions = { lsp = { enabled = true } },
})

vim.keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle render-markdown" })
