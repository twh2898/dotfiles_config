let mapleader = ","

" Spell check
nnoremap <leader>ss :setlocal spell!<CR>
nnoremap <leader>st :syntax spell toplevel<CR>

" Line Movement
function! ShiftLineUp()
    if line('.') > 1
        normal ddkP
    endif
endfunction
nnoremap <C-up> :call ShiftLineUp()<CR>

function! ShiftLineDown()
    normal ddp
endfunction
nnoremap <C-down> :call ShiftLineDown()<CR>

" Smart Home
inoremap <Home> <Esc>^i
nnoremap <Home> ^

" Enable Alt panel navigation for Vim
if !exists("*stdpath")
    execute "set <M-h>=\eh"
    execute "set <M-j>=\ej"
    execute "set <M-k>=\ek"
    execute "set <M-l>=\el"
end

" use alt+hjkl to move between split/vsplit panels
tnoremap <M-h> <C-\><C-n><C-w>h
tnoremap <M-j> <C-\><C-n><C-w>j
tnoremap <M-k> <C-\><C-n><C-w>k
tnoremap <M-l> <C-\><C-n><C-w>l
nnoremap <M-h> <C-w>h
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
nnoremap <M-l> <C-w>l

" Open new split / vsplit
nnoremap <leader>n :split<CR>
nnoremap <leader>v :vsplit<CR>

" Figlet banners
nnoremap <leader>fb :read !figlet -f big
nnoremap <leader>fn :read !figlet -f standard
nnoremap <leader>fs :read !figlet -f small

" Write as sudo
cnoremap w! w !sudo tee > /dev/null %

" buftabs nav
noremap <C-left> :bprev<CR>
noremap <C-right> :bnext<CR>

" Re-wrap paragraph
command! Rewrap normal {v}gq
noremap <A-q> :Rewrap<CR>
noremap <C-k><C-q> :Rewrap<CR>
" Enable Alt-q key for Vim
if !exists("*stdpath")
    execute "set <M-q>=\eq"
end

" Map :W to :w
command! W w

" Map :Q to :q
command! Q q

" Toggle wrap with ,w
nnoremap <leader>w :set wrap!<CR>

" Remove trailing whitespace
command! RemoveWhitespace :%s/\s\+$//e
nnoremap <leader>sw :RemoveWhitespace<CR>
nnoremap <C-k><C-s> :RemoveWhitespace<CR>

" Generic build and run scripts
command! GenBuild exec "![ -f build ] && ./build || ./%"
nnoremap <C-k>b :wa <CR> :GenBuild<CR>

command! GenRun exec "![ -f run ] && ./run || ./%"
nnoremap <C-k><C-b> :wa<CR> :GenBuild<CR>

command! GenBuildRun exec "![ -f build ] && ./build || [ -f run ] && ./run || ./%"
nnoremap <F5> :wa<CR> :GenBuildRun<CR>
