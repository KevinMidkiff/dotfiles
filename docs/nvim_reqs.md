neovim configuration requirements
=================================

- Telescope (with showing the file)
- No top buffer line, use `<leader>fb` to show open buffers (show file)
    - possible to show if small?
- Gitsigns, more minimal
- Better cattpuccin theme, I like some italics (do some research)
- LSP... (mason)
    - Configurable re-formatting
    - No lightbulb, just a single colored dot (yellow/red)
    - Only show error on highlighted issue
    - Completions, with docs showing up
    - With code jumping, I like `lspsaga`
- Package manager (packer)
- Language specific?
    - Python - venv-selector
    - Markdown preview is nice
- MUST copy to clipboard
- Current used languages:
    - Rust
    - Python
    - Bash
    - C/C++

Is anything else needed?

- treesitter?

## Don't Need
- Diff views
- Idk what all these ones are - research them
    ```lua
    use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
    use "nvim-lua/plenary.nvim"  -- Useful lua functions used ny lots of plugins
    use "projekt0n/github-nvim-theme"
    use "windwp/nvim-autopairs"
    use "numToStr/Comment.nvim"
    use "junegunn/goyo.vim"
    use 'kyazdani42/nvim-web-devicons'
    use 'kyazdani42/nvim-tree.lua'
    use "akinsho/bufferline.nvim"
    use "moll/vim-bbye"
    ```
