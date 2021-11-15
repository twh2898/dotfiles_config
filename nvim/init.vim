"
" ~/.config/nvim/init.vim
"

set number

call plug#begin('~/.vim/plugged')
    " Plugin Section

    " Themes
    Plug 'rakr/vim-one'

    " NERDTree
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'

    " Toml
    Plug 'cespare/vim-toml'

    " Lua
    Plug 'twh2898/vim-lua'
call plug#end()

" neovim uses stdpath('config') while vim uses ~/.vim
if exists("*stdpath")
    let s:cwd = stdpath('config')
else
    let s:cwd = '~/.vim'
endif
let s:deps = [
            \'colors',
            \'keys',
            \'macro',
            \'openterm',
            \'nerdtree',
            \'format',
            \'lua',
            \'python',
            \]

for dep in s:deps
    call util#Requires(s:cwd, dep)
endfor

set hidden

set nobackup
set nowritebackup

set updatetime=300

set shortmess+=c

" Enable Mouse
set mouse=a

"Text Folding
set foldmethod=syntax
set foldlevel=20

" Set Tab Size to 4 spaces
set tabstop=4
set shiftwidth=4
set expandtab

" Text encoding (does nothing)
set encoding=UTF-8

" Light Numbers
set number

" Open new split panes to right and below
set splitright
set splitbelow

" Ignore case while searching
set ignorecase

" Ignore case while completing file paths
set wildignorecase

" Enable spell check
autocmd FileType markdown setlocal spell
autocmd FileType c setlocal spell
autocmd FileType cpp setlocal spell
autocmd FileType cmake setlocal spell
autocmd FileType python setlocal spell

" Persistent  undo
if has('persistent_undo')
    set undofile
    set undodir=$HOME/.vim/undo
endif

" Yank to system clipboard
set clipboard=unnamedplus

