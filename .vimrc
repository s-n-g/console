" Basic settings ---------------------------{{{
" marker folding
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END


" powerline
" this will make it work on tmux
set t_Co=256


set nocompatible
syntax on
filetype plugin on
set laststatus=2
set nocul

" if path+=** is used,   complete-=i
" has to be used too, so that we don't scan all
" files every time a complete action is performed
set path+=**
set complete-=i
set wildmenu

set autoindent
set background=dark
set backspace=indent,eol,start
set fileencodings=ucs-bom,utf-8,default,latin1
set helplang=el
set history=50
set nomodeline
set mouse=a
set pastetoggle=<F10>
set printoptions=paper:a4
set ruler
set relativenumber
set number

set showmatch
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set termencoding=utf-8
set window=46


set guifont=Monospace\ 13
colorscheme anotherdark

noremap <F12> :colorscheme darkZ<CR>
noremap <S-F12> :colorscheme default<CR>

" convert tabs to spaces
set tabstop=4
set shiftwidth=4
set expandtab
set smarttab

" Disable Arrow keys
" https://vi.stackexchange.com/questions/5851/how-to-disable-arrow-keys-in-vim
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" In insert or command mode, move normally by using Ctrl
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>
cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" Remap ESC to jk
" inoremap jk <esc>
" inoremap <esc> <nop>
" }}}

" Custom commands ------------------------------- {{{
" Browse list of oldfiles
:command! Browse :99new +setl\ buftype=nofile | 0put =v:oldfiles | nnoremap <buffer> <CR> :e <C-r>=getline('.')<CR><CR>

" Open multiple files from within vim
" e.g.      :Edit *.html
" http://vim.wikia.com/wiki/Load_multiple_files_with_a_single_command
com! -complete=file -nargs=* Edit silent! exec "!vim --servername " . v:servername . " --remote-silent ".escape(<q-args>,'\')
" }}}

" Search in all currently opened buffers
" from http://vim.wikia.com/wiki/Search_on_all_opened_buffers
" With this, the command :Vim pattern will search for pattern
" in all current buffers, and will populate the quickfix list after first
" clearing it
function! ClearQuickfixList()
    call setqflist([])
endfunction
function! Vimgrepall(pattern)
    call ClearQuickfixList()
    exe 'bufdo vimgrepadd ' . a:pattern . ' %'
    cnext
endfunction
command! -nargs=1 Vim call Vimgrepall(<f-args>)

" Mappings ---------------------------- {{{

" Spellchecking
map <F8> :setlocal spell! spelllang=en_us<CR>
map <S-F8> :setlocal spell! spelllang=el<CR>
" }}}

" Leader  Mappings ----------------------------- {{{

" List all buffers and wait for selection
" https://stackoverflow.com/questions/53664/how-to-effectively-work-with-multiple-files-in-vim/44647932#44647932
nnoremap <Leader>b :set nomore<Bar>:ls<Bar>:set more<CR>:b<Space>

" open my .vimrc
nnoremap <Leader>ev :vsplit $MYVIMRC<cr>
" source .vimrc
nnoremap <Leader>sv :source $MYVIMRC<cr>

" create a new html file
nnoremap <Leader>html :set syntax=html<cr>:setf html<cr>:1,$d<cr>i<!DOCTYPE html><cr><html lang="en"><cr><head><cr><title></title><cr><meta charset="UTF-8"><cr><meta name="keywords" content="" /><cr><meta name= "viewport" content="width=device-width, initial-scale=1"><cr><link rel="icon" type="image/png" href="" /><cr><link rel="stylesheet" href=""><cr><script type="text/javascript" src=""></script><cr><link rel="alternate" type="application/rss+xml" title="" href="my.rss" /><cr></head><cr><body><cr><p></p><cr></body><cr></html><esc>/title<cr>f>a

let maplocalleader = "\\"
autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>
autocmd FileType sh     nnoremap <buffer> <localleader>c I#<esc>
autocmd FileType html     nnoremap <buffer> <localleader>c I<!-- <esc>A --><esc>
autocmd FileType html     vnoremap <buffer> <localleader>c s<!--<cr>--><esc>P
" }}}

" https://www.everythingcli.org/use-ranger-as-a-file-explorer-in-vim/
function RangerExplorer()
    exec "silent !ranger --choosefile=/tmp/vim_ranger_current_file " . expand("%:p:h")
    if filereadable('/tmp/vim_ranger_current_file')
        exec 'edit ' . system('cat /tmp/vim_ranger_current_file')
        call system('rm /tmp/vim_ranger_current_file')
    endif
    redraw!
endfun
map <Leader>x :call RangerExplorer()<CR>

" http://vim.wikia.com/wiki/VimTip97
" If buffer modified, update any 'Last modified: ' in the first 20 lines.
" 'Last modified: ' can have up to 10 characters before (they are retained).
" Restores cursor and window position using save_cursor variable.
function! LastModified()
  if &modified
    let save_cursor = getpos(".")
    let n = min([20, line("$")])
    keepjumps exe '1,' . n . 's#^\(.\{,10}Last modified: \).*#\1' .
          \ strftime('%e/%m/%Y %T %z') . '#e'
    call histdel('search', -1)
    call setpos('.', save_cursor)
  endif
endfun
autocmd BufWritePre * call LastModified()

" plug
call plug#begin('~/.vim/plugged')
Plug 'drmikehenry/vim-fontsize',{'on': 'VimFontSize'}
call plug#end()


" vim-session
let g:session_autosave = 'yes'
let g:session_autoload = 'no'
let g:session_autosave_periodic = '5'
let g:session_autosave_silent = 'true'

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

