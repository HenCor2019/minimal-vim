local neotest = require("neotest")

-- Como tienes node/go/python en el Mac, neotest ejecuta los tests en el host
-- (no necesita docker exec). El "Debug test" usa los adaptadores de DAP.
neotest.setup({
    adapters = {
        require("neotest-golang"),
        require("neotest-python")({ runner = "pytest" }),
        require("neotest-jest")({
            jestCommand = "npx jest --",
        }),
        require("neotest-vitest"),
    },
})

-- ── Keymaps: prefijo ,t (testing); ,tm ya lo usa render-markdown ──────
local map = vim.keymap.set
map("n", "<leader>tn", function() neotest.run.run() end, { desc = "Test: más cercano" })
map("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end, { desc = "Test: archivo actual" })
map("n", "<leader>td", function() neotest.run.run({ strategy = "dap" }) end, { desc = "Test: depurar el más cercano" })
map("n", "<leader>ts", function() neotest.summary.toggle() end, { desc = "Test: panel resumen" })
map("n", "<leader>to", function() neotest.output.open({ enter = true }) end, { desc = "Test: ver salida" })
map("n", "<leader>tw", function() neotest.watch.toggle() end, { desc = "Test: watch archivo" })
