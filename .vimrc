"""""""""""""""
" SET ENCODING
"""""""""""""""

set encoding=utf-8
set fileencoding=utf-8
scriptencoding utf-8

"""""""""""""""
" LOAD PLUGINS
"""""""""""""""

call plug#begin('~/.vim/plugged')
" Make 'cw' and 'cW' work properly.
Plug 'ap/vim-you-keep-using-that-word'
" Surround text in brackets, quotes, tags.
Plug 'tpope/vim-surround'
" Toggle commented lines with `gc`.
Plug 'tpope/vim-commentary'
" Repeat commands from plugins properly.
Plug 'tpope/vim-repeat'
" Handle sessions easily.
Plug 'tpope/vim-obsession'
" Enable snippets.
Plug 'SirVer/ultisnips'
" Wiperblades colour scheme.
Plug 'jdw1996/vim-wiperblades'
" Better LaTeX support.
Plug 'lervag/vimtex', {'for' : 'tex'}
" Dart support.
Plug 'dart-lang/dart-vim-plugin', {'for' : 'dart'}
call plug#end()

""""""""""""""
" BASIC SETUP
""""""""""""""

" Handle multiple unsaved buffers properly.
set hidden

" Deal with backspace properly.
set backspace=indent,eol,start

" Map `W` to write as well.
command W w
command Q q
command Wq wq
command WQ wq

" Make `Y` yank till end of line.
nnoremap Y y$

" Move to beginning and end of line easier.
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L g_
nnoremap gh H
nnoremap gl L

" Use leader key to access system clipboard.
nnoremap <Leader>y "+y
nnoremap <Leader>d "+d
nmap <Leader>Y "+Y
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
vmap <Leader>Y "+Y
nnoremap <silent> <Leader>p :set paste<CR>"+p:set nopaste<CR>
nnoremap <silent> <Leader>P :set paste<CR>"+P:set nopaste<CR>
vnoremap <silent> <Leader>p :set paste<CR>"+p:set nopaste<CR>
vnoremap <silent> <Leader>P :set paste<CR>"+P:set nopaste<CR>

" Auto-detect indentation and filetype.
set autoindent
filetype plugin indent on

" Setup default indentation.
set softtabstop=4
set shiftwidth=4
set expandtab

" Soft word wrap.
set wrap
set linebreak
set nolist
set breakindent
set showbreak=┊
set breakindentopt=sbr
set breakindentopt=shift:1

" Make split windows more intuitive.
set splitbelow
set splitright

" Easier scrolling.
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>
vnoremap <Up> <C-y>
vnoremap <Down> <C-e>

" Easily navigate splits.
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>

" Resize splits.
nnoremap <silent> <C-Left>  :vertical resize -1<CR>
nnoremap <silent> <C-Down>  :resize -1<CR>
nnoremap <silent> <C-Up>    :resize +1<CR>
nnoremap <silent> <C-Right> :vertical resize +1<CR>

" Better command-line completion.
set wildmenu

" Save swap and backup files in `.vim`.
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

" Indicate sentence's end with two spaces.
set cpoptions+=J

" Increment and decrement letters with Ctrl-a and Ctrl-x.
set nrformats+=alpha

" Highlight search results and clear highlighting.
set hlsearch
nnoremap <silent> <Leader><Space> :nohlsearch<CR>

"""""""""""""
" APPEARANCE
"""""""""""""

" Set colour scheme.
colorscheme wiperblades

" Tell terminal how to italicize.
set t_ZH=[3m
set t_ZR=[23m

"""""""""""""
" STATUSLINE
"""""""""""""

" Always show the statusline.
set laststatus=2

" Customize the statusline.
set statusline=
set statusline+=%f\ %h%w%m%r  " Show filename, window flags.
set statusline+=%=            " Insert a break.
set statusline+=\ %Y          " Show the type of file in the buffer.
set statusline+=\ %l:%v       " Show the line number and virtual column number.
set statusline+=\ %P          " Show the percent progress through the file.

""""""""""""""""""
" PLUGIN SETTINGS
""""""""""""""""""

" Better keybindings for UltiSnipsExpandTrigger.
let g:UltiSnipsExpandTrigger = '<Tab>'
let g:UltiSnipsJumpForwardTrigger = '<Tab>'
let g:UltiSnipsJumpBackwardTrigger = '<S-Tab>'

" Always use LaTeX in `*.tex` files.
let g:tex_flavor='latex'

" Use proper options for latexmk.
let g:vimtex_compiler_latexmk = {
      \ 'options' : [
      \   '-pdf'
      \ ]
      \}

" Set the directory to look for snippets in.
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/my-snippets']

""""""""""""""
" SPELL-CHECK
""""""""""""""

" Set up spell-check.
set spelllang=en_ca
augroup spell_check
    autocmd!
    autocmd BufRead,BufNewFile *.md,*.tex setlocal spell
augroup END

" Don't spell-check LaTeX comments.
let g:tex_comment_nospell=1

"""""""""""""""""""""""""""
" MACROS & CUSTOM COMMANDS
"""""""""""""""""""""""""""

" Delete trailing whitespace on save.
function! <SID>StripWhitespace() abort
    let pos = getcurpos()
    %s/\s\+$//e
    %s#\($\n\s*\)\+\%$##e
    call setpos('.', pos)
endfunction
augroup strip_trailing_whitespace
    autocmd!
    autocmd BufWritePre * call <SID>StripWhitespace()
augroup END

" Recognize `*.h` files as C files.
augroup c_header_files
    autocmd!
    autocmd BufRead,BufNewFile *.h set filetype=c
augroup END

" Copy all macro.
let @a = 'gg"+yG``'

" Get current highlight group.
function! SynStack() abort
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc
nnoremap <Leader>sy :call SynStack()<CR>
