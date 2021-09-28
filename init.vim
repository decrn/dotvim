
" augroup CoqtailHighlights
"   autocmd!
"   autocmd ColorScheme *
"     \  hi def CoqtailChecked ctermbg=0
"     \| hi def CoqtailSent    ctermbg=255
" augroup END

call plug#begin('~/.vim/plugged')
Plug 'ayu-theme/ayu-vim'
Plug 'godlygeek/tabular'
Plug 'dense-analysis/ale'
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar'
Plug 'neovimhaskell/haskell-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'
Plug 'caenrique/nvim-toggle-terminal'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'whonore/Coqtail'
" load icons LAST
Plug 'ryanoasis/vim-devicons'
call plug#end()

set termguicolors
let ayucolor="dark" " light|mirage|dark

colorscheme ayu
syntax on
filetype plugin indent on

set nocompatible
set number
set nowrap
set showmode
set smartcase
set smarttab
set smartindent
set autoindent
set softtabstop=2
set shiftwidth=2
set expandtab
set incsearch
set mouse=a
set history=1000
set encoding=UTF-8
set autowriteall " enable switch between terminal/code without 'no write since last change'

set completeopt=menuone,menu,longest

set wildignore+=*\\tmp\\*,*.swp,*.swo,*.zip,.git,.cabal-sandbox
set wildmode=longest,list,full
set wildmenu
set completeopt+=longest

set t_Co=256

set cmdheight=1

" TABULARIZE
let g:haskell_tabular = 1

vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
vmap a/ :Tabularize /\/\*<CR>
" NERDTree
set wildignore+=*.pyc,*.obj,*.svn,*.swp,*.class,*.hg,*.DS_Store,*.min.,*.hi
let NERDTreeRespectWildIgnore=1

nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-f> :NERDTreeFind<CR>
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <F3> :TagbarToggle<CR>

au VimEnter * NERDTree
au VimEnter * Tagbar
autocmd VimEnter * wincmd p " sets focused window correctly (instead of focusing nerdtree)

" neovimhaskell/haskell-vim
let g:haskell_enable_quantification = 1   " to enable highlighting of `forall`
let g:haskell_enable_recursivedo = 1      " to enable highlighting of `mdo` and `rec`
let g:haskell_enable_arrowsyntax = 1      " to enable highlighting of `proc`
let g:haskell_enable_pattern_synonyms = 1 " to enable highlighting of `pattern`
let g:haskell_enable_typeroles = 1        " to enable highlighting of type roles
let g:haskell_enable_static_pointers = 1  " to enable highlighting of `static`
let g:haskell_backpack = 1                " to enable highlighting of backpack keywords

" preservim/tagbar
" see https://github.com/preservim/tagbar/wiki#haskell
let g:tagbar_type_haskell = {
    \ 'ctagsbin'  : 'hasktags',
    \ 'ctagsargs' : '-x -c -o-',
    \ 'kinds'     : [
        \  'm:modules:0:1',
        \  'd:data: 0:1',
        \  'd_gadt: data gadt:0:1',
        \  't:type names:0:1',
        \  'nt:new types:0:1',
        \  'c:classes:0:1',
        \  'cons:constructors:1:1',
        \  'c_gadt:constructor gadt:1:1',
        \  'c_a:constructor accessors:1:1',
        \  'ft:function types:1:1',
        \  'fi:function implementations:0:1',
        \  'i:instance:0:1',
        \  'o:others:0:1'
    \ ],
    \ 'sro'        : '.',
    \ 'kind2scope' : {
        \ 'm' : 'module',
        \ 'c' : 'class',
        \ 'd' : 'data',
        \ 't' : 'type',
        \ 'i' : 'instance'
    \ },
    \ 'scope2kind' : {
        \ 'module'   : 'm',
        \ 'class'    : 'c',
        \ 'data'     : 'd',
        \ 'type'     : 't',
        \ 'instance' : 'i'
    \ }
\ }

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline_theme='ayu_mirage'

" fzf
nnoremap <F4> :Rg<CR>

" ale sanity stuff
nnoremap gd :ALEGoToDefinition<CR>

" floaterm
nnoremap <silent> <C-z> :ToggleTerminal<Enter>
tnoremap <silent> <C-z> <C-\><C-n>:ToggleTerminal<Enter>
set shell=/bin/zsh

" devicons color
let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'
let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['hs'] = s:purple " sets the color of css files to blue
let g:NERDTreeExtensionHighlightColor['md'] = s:blue " sets the color of css files to blue
let g:WebDevIconsDefaultFileSymbolColor = s:blue " sets the color for files that did not match any rule

" coqtail
noremap <F7> :CoqUndo<CR>:CoqJumpToEnd<CR>
noremap <F8> :CoqToLine<CR>:CoqJumpToEnd<CR>
noremap <F9> :CoqNext<CR>:CoqJumpToEnd<CR>

function! g:CoqtailHighlight()
    hi def link CoqtailChecked Visual
    hi def link CoqtailSent PmenuSel
endfunction
