require("mason").setup()
require("lsp-format").setup {}

local on_attach = require("user.lsp.opts").on_attach
local on_attach_fmt = require("user.lsp.opts").on_attach_fmt
local on_init = require("user.lsp.opts").on_init
local capabilities = require("user.lsp.opts").capabilities

-- Servers to specifically enable
local servers = { "lua_ls", "rust_analyzer", "ruff", "clangd" }

-- DO NOT format the languages in this list
local disabled_fmt = { "rust_analyzer" }

for _, server in ipairs(servers) do
  local attach_fn = on_attach_fmt
  if not vim.tbl_contains(disabled_fmt, server) then
    attach_fn = on_attach
  end

  local opts = {
    on_attach = attach_fn,
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
