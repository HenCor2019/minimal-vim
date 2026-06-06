vim.pack.add({
    "https://github.com/bluz71/vim-moonfly-colors",
    "https://github.com/rose-pine/neovim",
    "https://github.com/nvim-mini/mini.nvim",
    "https://github.com/rafamadriz/friendly-snippets",
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", branch = "main" },
    "https://github.com/neovim/nvim-lspconfig",
    "https://github.com/mason-org/mason.nvim",
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/stevearc/conform.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    { src = "https://github.com/ThePrimeagen/harpoon", branch = "harpoon2" },
    "https://github.com/zbirenbaum/copilot.lua",
    "https://github.com/CopilotC-Nvim/CopilotChat.nvim",
    "https://github.com/mrjones2014/smart-splits.nvim",
    "https://github.com/MeanderingProgrammer/render-markdown.nvim",
    "https://github.com/folke/snacks.nvim",
    -- Debug (DAP)
    "https://github.com/mfussenegger/nvim-dap",
    "https://github.com/nvim-neotest/nvim-nio",
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/theHamsta/nvim-dap-virtual-text",
    -- Testing (neotest)
    "https://github.com/nvim-neotest/neotest",
    "https://github.com/fredrikaverpil/neotest-golang",
    "https://github.com/nvim-neotest/neotest-python",
    "https://github.com/nvim-neotest/neotest-jest",
    "https://github.com/marilari88/neotest-vitest",
})

require("plugins.mini-files")
require("plugins.mini-notify")
require("plugins.mini-cmdline")
require("plugins.mini-surround")
require("plugins.mini-pick")
require("plugins.mini-completion")
require("plugins.mini-snippets")
require("plugins.mini-diff")
require("plugins.mini-animate")
require("plugins.conform")
require("plugins.harpoon")
require("plugins.copilot")
require("plugins.copilot-chat")
require("plugins.smart-splits")
require("plugins.mini-icons")
require("plugins.render-markdown")
require("plugins.snacks")
-- Tier 1 funcional de mini.nvim (edición)
require("plugins.mini-ai")
require("plugins.mini-pairs")
require("plugins.mini-move")
require("plugins.mini-splitjoin")
-- Debug y testing
require("plugins.dap")
require("plugins.neotest")
