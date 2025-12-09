-- Automatically install packer
local install_path = vim.fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = vim.fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  -- Base required plugins
  use "wbthomason/packer.nvim"
  use "nvim-lua/popup.nvim"
  use "nvim-lua/plenary.nvim"

  -- Themes
  use { "catppuccin/nvim", as = "catppuccin" }
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }

  -- snippets (used by cmp for completing snippets)
  -- NOTE: Snippet engine is required for nvim-cmp
  use "L3MON4D3/LuaSnip"             --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- Completion plugins
  use "hrsh7th/nvim-cmp"         -- base completion plugin
  use "hrsh7th/cmp-path"         -- path completions
  use "hrsh7th/cmp-cmdline"      -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lua"
  use "hrsh7th/cmp-buffer"       -- buffer completions

  -- Telescope
  use "nvim-telescope/telescope.nvim"
  use 'nvim-telescope/telescope-media-files.nvim'

  -- Treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"

  -- Git
  use "lewis6991/gitsigns.nvim"
  use "sindrets/diffview.nvim"

  -- LSP
  use "hrsh7th/cmp-nvim-lsp"
  use "williamboman/mason.nvim"
  use "williamboman/mason-lspconfig.nvim"
  use "neovim/nvim-lspconfig"
  use "lukas-reineke/lsp-format.nvim"
  use({
    'nvimdev/lspsaga.nvim',
    after = 'nvim-lspconfig',
    -- Locking version for now due to bug: https://github.com/nvimdev/lspsaga.nvim/issues/1522
    commit = 'd027f8b',
    config = function()
      require('lspsaga').setup({
        symbol_in_winbar = {
          enable = false,
        }
      })
    end,
  })


  -- Garbage bin of things I maybe need--
  -- use "numToStr/Comment.nvim"
  -- use "windwp/nvim-autopairs"
  -----

  -- Less certain that I want --
  -- use 'kyazdani42/nvim-tree.lua'
  -- use "akinsho/bufferline.nvim" -- adds top "tab" line in nvim
  -----

  -- Misc
  use "iamcco/markdown-preview.nvim"
  use "linux-cultist/venv-selector.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
