" ========== Status line ==========

" Always show the status line
set laststatus=2

" Modes
let g:currentmode={
            \ 'n'  : 'NORMAL',
            \ 'v'  : 'VISUAL',
            \ 'V'  : 'VISUAL',
            \ 's'  : 'SELECT',
            \ 'S'  : 'SELECT',
            \ 'c'  : 'COMMAND',
            \ 'r'  : 'COMMAND',
            \ 'i'  : 'INSERT',
            \ 'R'  : 'REPLACE',
            \ 't'  : 'TERMINAL',
            \ ''   : 'MODELESS'
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

" Get the current working branch
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

" Parse git branch for the status line
function! StatuslineGit()
  let l:branchname = system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

autocmd WinEnter,BufWinEnter,FileType,ColorScheme,SessionLoadPost * let w:branch = StatuslineGit()

" Format the status line
set statusline=
set statusline+=\ %{currentmode[mode()]}\   " current mode
set statusline+=%{w:branch}                 " insert the branch name
set statusline+=%<                          " start truncating here when screen too narrow
set statusline+=\ %f                        " relative file location
set statusline+=%r                          " ro flag
set statusline+=%{&modified?'*':''}         " modified flag
set statusline+=\                           " Add space
set statusline+=%=                          " seperation point
set statusline+=[%l,%02.c]                  " line and column number
set statusline+=[%02.p%%]                   " percent through file
