local dap = require("dap")
local dapui = require("dapui")

-- ── UI y valores inline ──────────────────────────────────────────────
require("nvim-dap-virtual-text").setup()
dapui.setup()

-- Abrir/cerrar el panel de debug automáticamente al iniciar/terminar.
dap.listeners.before.attach.dapui_config = function() dapui.open() end
dap.listeners.before.launch.dapui_config = function() dapui.open() end
dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

-- Signos en la columna izquierda.
vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })

-- ── Rutas de Mason ───────────────────────────────────────────────────
local mason = vim.fn.stdpath("data") .. "/mason"
local debugpy_python = mason .. "/packages/debugpy/venv/bin/python"
local js_debug = mason .. "/bin/js-debug-adapter"

-- ╔══════════════════════════════════════════════════════════════════╗
-- ║ NOTA DOCKER: tus proyectos corren en docker-compose con el código ║
-- ║ montado como volumen, así que las rutas coinciden. Solo tienes    ║
-- ║ que: (1) exponer el puerto de debug en el contenedor y (2) ajustar ║
-- ║ remoteRoot/substitutePath al WORKDIR del contenedor (abajo: /app). ║
-- ╚══════════════════════════════════════════════════════════════════╝
local CONTAINER_WORKDIR = "/app" -- ⚠️ ajusta al WORKDIR de tu Dockerfile

-- ── Go (delve) ───────────────────────────────────────────────────────
-- Local: dlv lo lanza nvim. Docker: arranca en el contenedor con
--   dlv debug --headless --listen=:2345 --api-version=2 --accept-multiclient
dap.adapters.go = function(callback, config)
    if config.request == "attach" and config.mode == "remote" then
        callback({ type = "server", host = config.host or "127.0.0.1", port = config.port or 2345 })
    else
        callback({
            type = "server",
            port = "${port}",
            executable = { command = "dlv", args = { "dap", "-l", "127.0.0.1:${port}" } },
        })
    end
end
dap.configurations.go = {
    { type = "go", name = "Launch archivo (local)", request = "launch", program = "${file}" },
    { type = "go", name = "Launch paquete (local)", request = "launch", program = "${fileDirname}" },
    {
        type = "go",
        name = "Attach Docker (dlv :2345)",
        request = "attach",
        mode = "remote",
        host = "127.0.0.1",
        port = 2345,
        substitutePath = { { from = "${workspaceFolder}", to = CONTAINER_WORKDIR } },
    },
}

-- ── Python (debugpy) ─────────────────────────────────────────────────
-- Docker: arranca en el contenedor con
--   python -m debugpy --listen 0.0.0.0:5678 --wait-for-client -m <tu_modulo>
dap.adapters.python = function(cb, config)
    if config.request == "attach" then
        local addr = config.connect or config
        cb({ type = "server", host = addr.host or "127.0.0.1", port = assert(addr.port), options = { source_filetype = "python" } })
    else
        cb({ type = "executable", command = debugpy_python, args = { "-m", "debugpy.adapter" }, options = { source_filetype = "python" } })
    end
end
dap.configurations.python = {
    { type = "python", name = "Launch archivo (local)", request = "launch", program = "${file}", pythonPath = function() return "python" end },
    {
        type = "python",
        name = "Attach Docker (debugpy :5678)",
        request = "attach",
        connect = { host = "127.0.0.1", port = 5678 },
        pathMappings = { { localRoot = "${workspaceFolder}", remoteRoot = CONTAINER_WORKDIR } },
    },
}

-- ── Node / NestJS (js-debug) ─────────────────────────────────────────
-- Docker: arranca Nest en modo inspector dentro del contenedor:
--   node --inspect=0.0.0.0:9229 dist/main   (o: nest start --debug 0.0.0.0:9229)
-- y expón el puerto 9229 en docker-compose.
dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = { command = js_debug, args = { "${port}" } },
}
dap.configurations.typescript = {
    {
        type = "pwa-node",
        name = "Attach Docker NestJS (:9229)",
        request = "attach",
        address = "localhost",
        port = 9229,
        localRoot = "${workspaceFolder}",
        remoteRoot = CONTAINER_WORKDIR,
        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    },
    {
        type = "pwa-node",
        name = "Launch NestJS local (start:debug)",
        request = "launch",
        cwd = "${workspaceFolder}",
        runtimeExecutable = "npm",
        runtimeArgs = { "run", "start:debug" },
        sourceMaps = true,
        skipFiles = { "<node_internals>/**", "**/node_modules/**" },
    },
}
dap.configurations.javascript = dap.configurations.typescript

-- ── Keymaps: prefijo ,D (D mayúscula = Debug; no choca con ,d) ────────
local map = vim.keymap.set
map("n", "<leader>Db", dap.toggle_breakpoint, { desc = "DAP: breakpoint" })
map("n", "<leader>DB", function() dap.set_breakpoint(vim.fn.input("Condición: ")) end, { desc = "DAP: breakpoint condicional" })
map("n", "<leader>Dc", dap.continue, { desc = "DAP: continuar / iniciar" })
map("n", "<leader>Dn", dap.step_over, { desc = "DAP: step over" })
map("n", "<leader>Di", dap.step_into, { desc = "DAP: step into" })
map("n", "<leader>Do", dap.step_out, { desc = "DAP: step out" })
map("n", "<leader>Dt", dap.terminate, { desc = "DAP: terminar" })
map("n", "<leader>Dr", dap.repl.toggle, { desc = "DAP: REPL" })
map("n", "<leader>Dv", dapui.toggle, { desc = "DAP: panel UI" })
map({ "n", "v" }, "<leader>De", function() dapui.eval() end, { desc = "DAP: evaluar expresión" })
