-- require("user.archive_lsp.handlers").setup()
require("mason").setup()

local lspconfig = require "mason-lspconfig"

lspconfig.setup {
    ensure_installed = { "lua_ls", "rust_analyzer", "pyright", "gopls" },
}

-- Install lsp servers
require("lspconfig").lua_ls.setup {}
require("lspconfig").rust_analyzer.setup {}
require("venv-selector").setup {}

local on_attach = require("user.lsp.opts").on_attach
local on_init = require("user.lsp.opts").on_init
local capabilities = require("user.lsp.opts").capabilities

local disabled_servers = { }

lspconfig.setup_handlers {
  -- Automatically configure the LSP installed
  function(server_name)
    for _, name in pairs(disabled_servers) do
      if name == server_name then
        return
      end
    end

    local opts = {
      on_attach = on_attach,
      on_init = on_init,
      capabilities = capabilities,
    }

    local require_ok, server = pcall(require, "plugins.lsp.settings." .. server_name)
    if require_ok then
      opts = vim.tbl_deep_extend("force", opts, server)
    end

    require("lspconfig")[server_name].setup(opts)
  end,
}
