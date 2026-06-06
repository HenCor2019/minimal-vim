local chat = require("CopilotChat")

chat.setup({
    model = "claude-haiku-4.5",
    -- Incluye el archivo actual como contexto y activa el modo agente (@copilot)
    sticky = { "#buffer:active", "@copilot" },
    -- Confia en todas las herramientas de @copilot: edita archivos sin pedir confirmacion
    trusted_tools = true,
    window = {
        layout = "vertical",
        width = 0.4,
    },
})

vim.keymap.set({ "n", "v" }, "<leader>cc", function() chat.toggle() end, { desc = "CopilotChat toggle" })
vim.keymap.set({ "n", "v" }, "<leader>ce", function() chat.ask("Explain how this code works.") end,
    { desc = "CopilotChat explain" })
vim.keymap.set({ "n", "v" }, "<leader>cf", function() chat.ask("Fix the bugs in this code.") end,
    { desc = "CopilotChat fix" })
vim.keymap.set({ "n", "v" }, "<leader>cr", function() chat.ask("Review this code and suggest improvements.") end,
    { desc = "CopilotChat review" })
vim.keymap.set("n", "<leader>cq", function()
    local input = vim.fn.input("Quick Chat: ")
    if input ~= "" then
        chat.ask(input)
    end
end, { desc = "CopilotChat quick question" })
