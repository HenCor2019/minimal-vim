local MiniPick = require("mini.pick")
local MiniExtra = require("mini.extra")
MiniPick.setup()
MiniExtra.setup()

-- Usa mini.pick como menú de selección de vim.ui.select (code actions del LSP,
-- etc.); reemplaza el popup nativo por la ventana flotante del picker.
vim.ui.select = MiniPick.ui_select

vim.keymap.set("n", "<leader>pp", function() MiniPick.builtin.files() end, { desc = "File picker" })
vim.keymap.set("n", "<leader>ps", function() MiniPick.builtin.grep({ pattern = vim.fn.expand("<cword>") }) end, { desc = "Grep word under cursor" })
vim.keymap.set("n", "<leader>vh", function() MiniPick.builtin.help() end, { desc = "Help picker" })
vim.keymap.set("n", "<leader>xx", function() MiniExtra.pickers.diagnostic() end, { desc = "Diagnostics picker" })
vim.keymap.set("n", "<leader>pk", function() MiniExtra.pickers.keymaps() end, { desc = "Keymaps picker" })
