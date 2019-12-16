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
" Surround text in brackets, quotes, tags.
Plug 'tpope/vim-surround'
" Toggle commented lines with `gc`.
Plug 'tpope/vim-commentary'
" Handle sessions easily.
Plug 'tpope/vim-obsession'
" Git support.
Plug 'tpope/vim-fugitive'
call plug#end()

""""""""""""""
" BASIC SETUP
""""""""""""""

" Turn on syntax highlighting.
syntax on

" Set defaults for indentation.
set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set noexpandtab

" Load filetype-specific settings.
filetype plugin indent on

" Handle multiple unsaved buffers properly.
set hidden

" Deal with backspace properly.
set backspace=indent,eol,start

" Make `Y` yank till end of line.
nnoremap Y y$

" Make it easier to save the file.
nnoremap <silent> S :update<CR>

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

" Soft word wrap.
set wrap
set linebreak
set nolist
set breakindent
set showbreak=┊
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
set wildmode=longest,list
set wildmenu

" Don't automatically continue comments.
augroup comment_continuation
    autocmd!
    autocmd BufNewFile,BufRead * setlocal formatoptions-=cro
augroup END

" Save swap and backup files in `.vim`.
set backupdir=~/.vim/backup//
set directory=~/.vim/swp//

" Search with smart case matching.
set ignorecase
set smartcase

" Highlight search results and clear highlighting.
set hlsearch
nnoremap <silent> <Space> :nohlsearch<CR>

" Tell Vim where to find tags.
set tags^=./.git/tags;

"""""""""""""
" APPEARANCE
"""""""""""""

" Set colour scheme.
colorscheme default

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

""""""""""""""
" SPELL-CHECK
""""""""""""""

" Set up spell-check.
set spelllang=en_ca
augroup spell_check
    autocmd!
    autocmd BufRead,BufNewFile *.md,*.tex setlocal spell
augroup END

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

" Easier bracket and quote completion.
inoremap (( ()<Left>
inoremap )) (<CR>)<C-c>O
inoremap {{ {}<Left>
inoremap }} {<CR>}<C-c>O
inoremap [[ []<Left>
inoremap ]] [<CR>]<C-c>O
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap `` ``<Left>

" Highlight row and column in normal mode.
nnoremap <silent> <Leader>ch :set cursorline! cursorcolumn!<CR>

" Recognize `*.h` files as C files.
augroup c_header_files
    autocmd!
    autocmd BufRead,BufNewFile *.h set filetype=c
augroup END
