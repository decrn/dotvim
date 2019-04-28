let mapleader=","
let maplocalleader="\\"

filetype plugin indent on           " enable filetype plugins
syntax on                           " enable syntax highlighting
set number                          " Enable line numbers
set path=$PWD/**                    " Set path to nvim opened dir for fuzzy :find
set tabstop=4                       " The width of a TAB is set to 4.  Still it is a \t. It is just that Vim will interpret it to be having a width of 4.
set shiftwidth=4                    " Indents will have a width of 4
set softtabstop=4                   " Sets the number of columns for a TAB
set expandtab                       " Expand TABs to spaces
set nocursorline                    " Highlight the current line (handled by iterm for performance)
set ttyfast                         " Faster scrolling if supported by term emu
set lazyredraw                      " Better performance (ties in with above)
set noshowmode                      " disable default mode indicator
set wildmenu                        " enable wildmenu (tab completion for :find etc)
set wrap                            " enable word wrapping
set encoding=utf-8                  " set default encoding
set mouse=a                         " enable mouse input for scrolling in iterm2 (empty means disabled)
set incsearch                       " show search matches as you type
set hlsearch                        " highlight search results
set ignorecase                      " ignore casing in search
set smartcase                       " ignore casing only if lowercase
set signcolumn=yes                  " permanently enables the gutter/sign column left of the line number
let $NVIM_TUI_ENABLE_TRUE_COLOR=1   " enable true color support for neovim in iTerm2

let g:python_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'

call plug#begin('~/vim/plugged')
" sanity
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'

" vcs
Plug 'sjl/splice.vim'

" color scheme
" Plug 'morhetz/gruvbox'
" Plug 'aonemd/kuroi.vim'
Plug 'srcery-colors/srcery-vim'

" language support 
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', {'do': './install.sh'}

" magic
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'bagrat/vim-buffet'
call plug#end()

" netrw config
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 18
" hide netrw from buffer list (:ls)
autocmd FileType netrw setl bufhidden=wipe

autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" color scheme
colorscheme srcery

" airline config
let g:airline_theme='srcery'

" language specifics

" JS / JSX / TS

let g:javascript_plugin_flow = 1

augroup typescript
    autocmd!
    " setting typescript things.
    let g:nvim_typescript#type_info_on_hold = 1
    let g:nvim_typescript#signature_complete = 1

    autocmd BufNewFile,BufRead *.ts set filetype=typescript
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
    nnoremap <leader>i :TSImport<CR>
    nnoremap <leader>d :TSDefPreview<CR>
    nnoremap <leader>t :TSType<CR>
    nnoremap <leader>f :TSGetCodeFix<CR> " this is called on insert leave
augroup END

" Opens netrw in vertical split
" SEE: https://stackoverflow.com/a/51199145 
" Toggle Vexplore with Ctrl-O
function! ToggleVExplorer()
    if exists("t:expl_buf_num")
        let expl_win_num = bufwinnr(t:expl_buf_num)
        let cur_win_num = winnr()

        if expl_win_num != -1
            while expl_win_num != cur_win_num
                exec "wincmd w"
                let cur_win_num = winnr()
            endwhile

            close
        endif

        unlet t:expl_buf_num
    else
        Vexplore
        let t:expl_buf_num = bufnr("%")
    endif
endfunction


source $HOME/.config/nvim/statusbar.vim


function! CheckFZF() abort
    let status = system('git rev-parse --is-inside-work-tree')
    execute status =~ 'true' ? 'GFiles' : 'Files'
endfun

nnoremap <C-F10> :edit ~/.config/nvim/init.vim<CR>
nnoremap <silent> <C-P> :call CheckFZF()<CR>
nnoremap <silent> <C-O> :call ToggleVExplorer()<CR>

" Move lines up and down, also works with blocks in visual mode.
nnoremap <A-Up> :m-2<CR>
nnoremap <A-Down> :m+<CR>
inoremap <A-Up> <Esc>:m-2<CR>
inoremap <A-Down> <Esc>:m+<CR>
vnoremap <A-Up> :m '<-2<CR>gv=gv
vnoremap <A-Down> :m '>+1<CR>gv=gv

let g:fzf_layout = { 'up': '~20%' }

let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }

" deoplete config
let g:deoplete#enable_at_startup = 1 " enable at start up
call deoplete#custom#option({
            \ 'auto_complete': v:false,
            \ 'auto_complete_delay': 370,
            \ 'camel_case': v:true,
            \ 'auto_refresh_delay': 50,
            \ 'smart_case': v:true,
            \ 'skip_multibyte': v:true,
            \ 'prev_completion_mode': 'length',
            \ 'min_pattern_length': 0,
            \ 'max_list': 50,
            \ 'skip_chars': ['(', ')', '<', '>'],
            \ })

let g:deoplete#sources#jedi#statement_length = 30
let g:deoplete#sources#jedi#short_types = 1

let g:deoplete#sources#ternjs#filetypes = [
            \ 'jsx',
            \ 'javascript.jsx',
            \ 'vue',
            \ 'javascript'
            \ ]

set completeopt+=noinsert
set shortmess+=c                " disable deoplete 'Pattern not found' etc messages

" deoplete mappings
inoremap <expr> <C-V> pumvisible() ? deoplete#close_popup() : deoplete#mappings#manual_complete()
inoremap <expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr> <S-TAB> pumvisible() ? "\<C-p>" : "\<S-TAB>"

" vim-buffet
" SEE https://github.com/bagrat/vim-buffet#colors
function! g:BuffetSetCustomColors()
    hi! BuffetCurrentBuffer ctermbg=10 ctermfg=8
    hi! BuffetActiveBuffer  ctermbg=0 ctermfg=10
    hi! BuffetBuffer        ctermbg=0 ctermfg=10
    hi! BuffetTrunc         ctermbg=0 ctermfg=10
    hi! BuffetTab           ctermbg=0 ctermfg=0
endfunction

let g:buffet_tab_icon = ""                  " the character to be used as an icon for the tab items in the tabline
let g:buffet_use_devicons = 0               " show file type icons (requires vim-devicons)
let g:buffet_new_buffer_name = "+"          " the character to be shown as the name of a new buffer
let g:buffet_modified_icon = "*"            " the character to be shown by the name of a modified buffer
let g:buffet_separator = "|"                " the character to be used for separating items in the tabline.
