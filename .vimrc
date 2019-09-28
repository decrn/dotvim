" make backspace behave sanely
set backspace=indent,eol,start

colorscheme koehler

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

"set a nicer status line
set laststatus=2 " enables the status line even when only 1 window is shown in the current tab page -- note the trailing space
set statusline=%<\ %f\ %m%r%y%w%=\ L:\ \%l\/\%L\ C:\ \%c\ 

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



