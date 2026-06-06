local MiniSnippets = require("mini.snippets")
MiniSnippets.setup({
    snippets = {
        MiniSnippets.gen_loader.from_lang(),
    },
})
MiniSnippets.start_lsp_server({ match = false })
