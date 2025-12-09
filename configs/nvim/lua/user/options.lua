-- :help options
local options = {
  backup = false,            -- creates a backup file
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  fileencoding = "utf-8",    -- the encoding written to a file
  mouse = "a",
  hlsearch = true,           -- highlight all matches on previous search pattern
  showmatch = true,
  incsearch = true,
  ignorecase = true,     -- ignore case in search patterns
  smartindent = true,    -- make indenting smarter again
  splitbelow = true,     -- force all horizontal splits to go below current window
  splitright = true,     -- force all vertical splits to go to the right of current window
  swapfile = false,      -- creates a swapfile
  termguicolors = true,  -- set term gui colors (most terminals support this)
  timeoutlen = 1000,     -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = true,       -- enable persistent undo
  updatetime = 300,      -- faster completion (4000ms default)
  writebackup = false,   -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,      -- convert tabs to spaces
  shiftwidth = 4,        -- the number of spaces inserted for each indentation
  tabstop = 4,           -- insert 2 spaces for a tab
  cursorline = true,     -- highlight the current line
  number = true,         -- set numbered lines
  relativenumber = true, -- set relative numbered lines
  numberwidth = 4,       -- set number column width to 2 {default 4}
  signcolumn = "yes",    -- always show the sign column, otherwise it would shift the text each time
  wrap = false,          -- display lines as one long line
  scrolloff = 8,         -- is one of my fav
  sidescrolloff = 8,
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.wo.colorcolumn = '80'

vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd [[set iskeyword+=-]]
-- vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
vim.api.nvim_create_autocmd("FileType", {
  pattern = "lua",
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
  end
})

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*" },
  command = [[:%s/\s\+$//e]]
})

-- diagnostic configuration
vim.diagnostic.config({
  -- lspsaga handles virtual text, this deduplicates any text that would show up
  virtual_text = false,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '●',
      [vim.diagnostic.severity.WARN] = '●',
      [vim.diagnostic.severity.INFO] = '■',
      [vim.diagnostic.severity.HINT] = '◆',
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = 'DiagnosticSignError',
      [vim.diagnostic.severity.WARN] = 'DiagnosticSignWarn',
    },
  },
})
