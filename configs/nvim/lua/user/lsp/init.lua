require("mason").setup()
require("lsp-format").setup {}
require("venv-selector").setup {}

local on_attach = require("user.lsp.opts").on_attach
local on_init = require("user.lsp.opts").on_init
local capabilities = require("user.lsp.opts").capabilities
local disabled_servers = {} -- Add any servers you want to skip

local servers = { "lua_ls", "rust_analyzer", "ruff", "clangd" }

for _, server in ipairs(servers) do
  if not vim.tbl_contains(disabled_servers, server) then
    local opts = {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }

    -- Load user-specific settings if available
    local ok, user_opts = pcall(require, "user.lsp.settings." .. server)
    if ok then
      opts = vim.tbl_deep_extend("force", opts, user_opts)
    end

    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
  end
end

