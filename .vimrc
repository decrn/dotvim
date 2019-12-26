" make backspace behave sanely
set backspace=indent,eol,start

" if exists('+termguicolors')
"     let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
"     let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"     set termguicolors
" endif

colorscheme challenger_deep
let g:challenger_deep_termcolors = 16
set background=dark

" add simple auto indenting
set autoindent

" allow editing another file while this one has unsaved changes
set hidden

" makes this 500 dollar monitor a notable upgrade from a 70s tty
syntax on

" enables line numbering
set number

" provides sane tab widths (vim defaults to 8)
set shiftwidth=4
set softtabstop=4
set expandtab " prefer spaces over tabs

" sets the vertical split character a space instead of pipe -- note the trailing space
:set fillchars+=vert:\ 

" set new splits to open to the right and below
set splitright
set splitbelow

" find a file in our current path recursively -- see L36
" enables command line completion preview
set wildmenu
set wildmode=list:full
set wildignorecase
set wildignore+=tags,cscope.out,.DS_STORE

" performance increases (note: these have a tradeoff)
set regexpengine=1
set noshowcmd
set synmaxcol=160

" enable search highlighting
set hlsearch

" set the default path to the current dir and all subdirs (see :find)
" change this value to a project-specific value if need be, e.g:  `:set path=app/views/*,app/controllers/*`
set path=.,**

" MAPPINGS
let mapleader = "\<Space>" " you can hit this one with both hands, way better than \ or ,
    " goto buffer
    nnoremap gb :ls<CR>:buffer<Space>

    "Switch to last edited file
    nnoremap <BS> <C-^>

    "Tab between buffers
    nnoremap <Tab> :bnext<CR>
    nnoremap <S-Tab> :bprevious<CR>

    " find a file in our current path, recursively -- see L36
    nnoremap <leader>f :find *

    " write, build, open quickfix window
    inoremap <F5> <Esc>:write<Bar>silent make<Bar>cwindow<CR>
    nnoremap <F5> :write<Bar>silent make<Bar>cwindow<CR>

    " shift line(s) up and down
    " == reindents

    " Delta maps to Meta+J on regular keyboards (read: non-apple ones)
    " Degree maps to Meta+K on regular keyboards (read: non-apple ones)
    nnoremap ∆ :m .+1<CR>==
    nnoremap ˚ :m .-2<CR>==
    inoremap ∆ <Esc>:m .+1<CR>==gi
    inoremap ˚ <Esc>:m .-2<CR>==gi
    vnoremap ∆ :m '>+1<CR>gv=gv
    vnoremap ˚ :m '<-2<CR>gv=gv

    nnoremap j :m .+1<CR>==
    nnoremap k :m .-2<CR>==
    inoremap j <Esc>:m .+1<CR>==gi
    inoremap k <Esc>:m .-2<CR>==gi
    vnoremap j :m '>+1<CR>gv=gv
    vnoremap k :m '<-2<CR>gv=gv

" ========== Status line ==========

" Always show the status line
set laststatus=2

" Modes
let g:currentmode={
            \ 'n'      : 'NORMAL',
            \ 'v'      : 'VISUAL',
            \ 'V'      : 'V LINE',
            \ "\<C-V>" : 'V BLOCK',
            \ 's'      : 'SELECT',
            \ 'S'      : 'SELECT',
            \ 'c'      : 'COMMAND',
            \ 'r'      : 'COMMAND',
            \ 'i'      : 'INSERT',
            \ 'R'      : 'REPLACE',
            \ 't'      : 'TERMINAL',
            \ ''       : 'MODELESS'
            \}

" Colors for the modes
let g:modecolor={
            \ 'NORMAL'   : 'ctermbg=green ctermfg=white guibg=green guifg=white',
            \ 'COMMAND'  : 'ctermbg=green ctermfg=white guibg=green guifg=white',
            \ 'VISUAL'   : 'ctermbg=green ctermfg=white guibg=green guifg=white',
            \ 'SELECT'   : 'ctermbg=green ctermfg=white guibg=green guifg=white',
            \ 'INSERT'   : 'ctermbg=green ctermfg=white guibg=green guifg=white',
            \ 'REPLACE'  : 'ctermbg=green ctermfg=white guibg=green guifg=white',
            \ 'TERMINAL' : 'ctermbg=green ctermfg=white guibg=green guifg=white',
            \}

" Format the status line
set statusline=
set statusline+=\ %{currentmode[mode()]}\   " current mode
set statusline+=%<                          " start truncating here when screen too narrow
set statusline+=\ %f                        " relative file location
set statusline+=%r                          " ro flag
set statusline+=%{&modified?'*':''}         " modified flag
set statusline+=\                           " Add space
set statusline+=%=                          " seperation point
set statusline+=[%l,%02.c]                  " line and column number
set statusline+=[%02.p%%]                   " percent through file

call plug#begin('~/.vim/plugged')

Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'https://github.com/sjl/tslime.vim.git'

call plug#end()

let g:tslime_ensure_trailing_newline = 1
let g:tslime_normal_mapping = '<leader>t'
let g:tslime_visual_mapping = '<leader>t'
let g:tslime_vars_mapping = '<leader>T'

