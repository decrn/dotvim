
filetype plugin indent on
syntax on
set number
set noshowmode

nnoremap <C-F10> :edit ~/.config/nvim/init.vim<CR>

let $NVIM_TUI_ENABLE_TRUE_COLOR=1

call plug#begin('~/vim/plugged')

" color scheme
Plug 'morhetz/gruvbox'

" language support 
Plug 'leafgarland/typescript-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'peitalin/vim-jsx-typescript'

Plug 'w0rp/ale'

" airline
Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'

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

" fuzzy file finding
set path=$PWD/**

" tab switching
nnoremap <C-Left> :tabprevious<CR>                                                                            
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>                                                                            
nnoremap <C-k> :tabnext<CR>

" color scheme
colorscheme gruvbox

" airline config
let g:airline_theme='hybrid'
" language specifics

" JS / JSX / TS

let g:javascript_plugin_flow = 1

let g:typescript_compiler_options = '--skipLibCheck'

" ALE linting
let g:ale_sign_column_always = 1
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'typescript': ['tslint']
\}

" tabs and spaces
set tabstop=4       " The width of a TAB is set to 4.
                    " Still it is a \t. It is just that
                    " Vim will interpret it to be having
                    " a width of 4.

set shiftwidth=4    " Indents will have a width of 4

set softtabstop=4   " Sets the number of columns for a TAB

set expandtab       " Expand TABs to spaces

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

map <silent> <C-O> :call ToggleVExplorer()<CR>

