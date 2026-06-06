-- Solo usamos el módulo `input` de snacks: reemplaza vim.ui.input (p. ej. el
-- prompt al renombrar un símbolo con el LSP) por una ventana flotante.
-- El resto de módulos de snacks quedan desactivados a propósito.
require("snacks").setup({
    input = { enabled = true },
})
