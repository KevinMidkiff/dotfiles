"r---------- Vundle Configurations -------
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Command-T
" Plugin 'wincent/command-t'

" GitRepo plugin Fugitive
Plugin 'tpope/vim-fugitive'

" Vim Colorschemes
Plugin 'flazz/vim-colorschemes'

" Status line plugin
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Less Syntax Highlighting Plugin
Plugin 'groenewege/vim-less'

" Enabling Markdown
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'

" NERDTree for better folder viewing
Plugin 'scrooloose/nerdTree'

" rust-lang syntax support
Plugin 'rust-lang/rust.vim'

" You Complete Me
Plugin 'Valloric/YouCompleteMe'
Bundle 'rdnetto/YCM-Generator'

" All of your Plugins must be added before the following line
call vundle#end()
" ----- END VUNDLE CONFIGURATIONS -----

" ----- Kevin's Configruation --------
set nu
syntax on
set expandtab
set tabstop=4
set shiftwidth=4
let mapleader=" "
filetype indent on
autocmd FileType less setlocal shiftwidth=2 tabstop=2
autocmd FileType html setlocal shiftwidth=2 tabstop=2
colorscheme badwolf
set cursorline
set showmatch
set incsearch
set hlsearch
" Leave hidden buffers open
set hidden
" vim-airline configuration
set rtp+=/usr/local/lib/python2.7/dist-packages/powerline/bindings/vim/
let g:airline#extensions#tabline#enabled = 1

" Airline themes
let g:airline_theme='raven'

set laststatus=2
let g:airline_powerline_fonts=1
set t_Co=256
set colorcolumn=80

" --- Key Bindings
" Reload the vimrc
map rr :source ~/.vimrc<CR>

" turn off search highlight
nnoremap <leader>, :nohlsearch<CR>

" toggle NERDTree
nnoremap <leader>ft :NERDTreeToggle<CR>

" show buffers
nnoremap <leader>l :ls<CR>

" helper for selecting a buffer
nnoremap <leader>b :b

" open vimrc
 nnoremap <leader>fed :e ~/.vimrc<CR>
