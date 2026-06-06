local smart_splits = require("smart-splits")
smart_splits.setup()

-- Crear splits
vim.keymap.set("n", "ss", "<cmd>split<cr>", { desc = "Split horizontal" })
vim.keymap.set("n", "sv", "<cmd>vsplit<cr>", { desc = "Split vertical" })

-- Moverse entre splits
vim.keymap.set("n", "<C-h>", smart_splits.move_cursor_left, { desc = "Move to left split" })
vim.keymap.set("n", "<C-j>", smart_splits.move_cursor_down, { desc = "Move to below split" })
vim.keymap.set("n", "<C-k>", smart_splits.move_cursor_up, { desc = "Move to above split" })
vim.keymap.set("n", "<C-l>", smart_splits.move_cursor_right, { desc = "Move to right split" })

-- Redimensionar splits
vim.keymap.set("n", "<A-h>", smart_splits.resize_left, { desc = "Resize split left" })
vim.keymap.set("n", "<A-j>", smart_splits.resize_down, { desc = "Resize split down" })
vim.keymap.set("n", "<A-k>", smart_splits.resize_up, { desc = "Resize split up" })
vim.keymap.set("n", "<A-l>", smart_splits.resize_right, { desc = "Resize split right" })
