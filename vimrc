" .vimrc: Main configuration file for the VIM text editor
" Author: Sudaraka Wijesinghe <sudaraka.org/contact>
" Source: https://github.com/sudaraka/dotfiles/blob/master/vimrc
" License: CC-BY
"
" Inspired by https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
"

" Initialize - Stage 1 {{{

set nocompatible " Required
filetype off

" Enable vundle plugin manager
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" }}}
" Plugins {{{

" Plugin: EditorConfig {{{

Plugin 'editorconfig/editorconfig-vim'

let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_preserve_formatoptions = 1

"}}}
" Plugin: CtrlP {{{

Plugin 'ctrlpvim/ctrlp.vim'
let g:ctrlp_max_height = 30
set wildignore+=*.pyc

" Use Silver Search CtrlP
" Inspired by http://robots.thoughtbot.com/faster-grepping-in-vim/
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -U --hidden -g "" --ignore "*.pyc" --ignore ".git" --ignore ".ropeproject" --ignore ".virtualenv" --ignore "__pycache__" --ignore "coverage/*"  --ignore "*.gif" --ignore "*.png"  --ignore "*.jpg" --ignore "node_modules/*" --ignore ".tmp/*" --ignore "_build/*" --ignore="dist/*" --ignore="vendor/*" --ignore="log/*"'
    let g:ctrlp_use_caching = 0
endif


" }}}
" Plugin: Nerdcommenter {{{

Plugin 'scrooloose/nerdcommenter'

"}}}
" Plugin: Vim-Fugitive {{{

Plugin 'tpope/vim-fugitive'

autocmd BufReadPost fugitive://* set bufhidden=delete

"}}}
" Plugin: Vim-Gitgutter {{{

Plugin 'airblade/vim-gitgutter'

"}}}
" Plugin: Vim-Airline {{{

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

set laststatus=2
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

"}}}
" Plugin: Syntastic {{{

Plugin 'scrooloose/syntastic'

let g:syntastic_javascript_checkers = ["eslint"]
let g:syntastic_javascript_eslint_exec = 'node_modules/.bin/eslint'
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = "✘"
let g:syntastic_warning_symbol = ""

"}}}
" Plugin: Vim-Multiple-Cursors {{{

Plugin 'terryma/vim-multiple-cursors'

"}}}

" Language: JavaScript {{{

" Plugin: Vim-JavaScript-Syntax {{{
" for JavaScript syntax highlighting enhancement

Plugin 'jelera/vim-javascript-syntax'

"}}}
" Plugin: Vim-JSON {{{

Plugin 'elzr/vim-json'

let g:vim_json_syntax_conceal = 0

"}}}
" Plugin: JSX {{{

Plugin 'jsx/jsx.vim'

"}}}

" }}}
" Language: PHP {{{

" Plugin: Phpfolding {{{

Plugin 'rayburgemeestre/phpfolding.vim'

"}}}

" Auto (Omni) complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" Convert old PHP tags (<?) or new <?php
function! g:PhpPort()
    let _s=@/
    let l = line(".")
    let c = col(".")

    %s/<?=/<?php echo /e
    %s/<?\s\+/<?php /e
    %s/<?$/<?php/e
    %s/<?\([^p]\)/<?php \1/e
    %s/\[\"\([^"]\+\)"]/['\1']/e
    retab

    let@/=_s
    call cursor(l, c)
endfunction

" }}}

" }}}
" Initialize - Stage 2 {{{

call vundle#end()
filetype plugin indent on

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Make sure Vim returns to the same line when you reopen a file.
augroup line_return
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

" Visual Mode */# from Scrooloose
function! s:VSetSearch()
  let temp = @@
  norm! gvy
  let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
  let @@ = temp
endfunction

vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR><c-o>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR><c-o>

" }}}
" Basic settings {{{

set autoindent
set autoread
set cursorline
set hidden
set lazyredraw
set linebreak
set nobackup
set nocompatible
set noswapfile
set nowrap
set nowritebackup
set number
set relativenumber
set ruler
set shiftround
set showcmd
set showmode
set spell
set splitbelow
set splitright
set title
set ttyfast

set backspace=indent,eol,start
set encoding=utf-8
set listchars=space:·,tab:▸–,eol:¬,extends:❯,precedes:❮
set modelines=0
set showbreak=↪
set termencoding=utf-8
set mouse-=a

" }}}
" Key bindings {{{

inoremap jj <Esc>
inoremap kk <Esc>

" Disable arrow key navigation in normal and visual modes
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <Left> <nop>
nnoremap <Right> <nop>
vnoremap <Up> <nop>
vnoremap <Down> <nop>
vnoremap <Left> <nop>
vnoremap <Right> <nop>

" Disable mouse wheel scrolling
noremap <ScrollWheelUp> <nop>
noremap <ScrollWheelDown> <nop>
inoremap <ScrollWheelUp> <nop>
inoremap <ScrollWheelDown> <nop>

" Disable middle mouse click (paste)
noremap <MiddleMouse> <nop>
inoremap <MiddleMouse> <nop>

" Rebind <Leader> key
let mapleader = ","

" F2: show/hide non-printable characters
noremap <F2> :set list!<CR>

" Removes highlight of your last search
noremap <F3> :nohl<CR>:call clearmatches()<CR>

" F4: split window horizontally
noremap <silent> <F4> :sp<CR>

" F5: split window vertically
noremap <silent> <F5> :vsp<CR>

" F6: close window/remove split (keeps the buffer intact)
nnoremap <silent> <F6> <C-w>c
vnoremap <silent> <F6> <C-w>c
inoremap <silent> <F6> <esc><C-w>c

" Ctrl+F4: close current buffer using bd
noremap <silent> <C-F4> :bd<CR>

" Ctrl+Shift+F4: close all buffers using bd
noremap <silent> <C-S-F4> :%bd<CR>

" Ctrl+S: save all buffers
nnoremap <silent> <C-s> :wa<CR>
inoremap <silent> <C-s> <C-o>:wa<CR>
vnoremap <silent> <C-s> <C-c>:wa<CR>

" Better copy & paste
set clipboard=unnamed
noremap <Leader>y "+yy
vnoremap <Leader>y "+yy<CR>
inoremap <Leader>y <C-o>"+yya
noremap <Leader>p "+p
noremap <Leader><S-p> "+P

" Ctrl+PgUP/Down: buffer switching within the window
noremap <silent> <C-PageUp> :bp<CR>
noremap <silent> <C-PageDown> :bn<CR>

" Ctrl+<movement>: move around the windows, instead of using Ctrl+w + <movement>
map <c-j> <c-w>j
map <c-Down> <c-w>j
map <c-k> <c-w>k
map <c-Up> <c-w>k
map <c-l> <c-w>l
map <c-Right> <c-w>l
map <c-h> <c-w>h
map <c-Left> <c-w>h

" map sort function to a key
nnoremap <silent> <Leader>s vip:!sort<CR>
vnoremap <silent> <Leader>s :!sort<CR>

" easier moving of code blocks
vnoremap < <gv^
vnoremap > >gv

" easier formatting of paragraphs
vmap Q gq
nmap Q gqap

" Ctrl+A: Select all (only in gui, conflicts with screen)
if has('gui_running')
    nnoremap <silent> <C-a> ggVG
endif

" Case conversions
inoremap <C-u> <esc>gUiwea
nnoremap <C-u> gUiw
vnoremap <C-u> gU
inoremap <C-l> <esc>guiwea
nnoremap <C-l> guiw
vnoremap <C-l> gu

" Bind semicolon to colon and avoid extra keystroke (shift) for commandline
nnoremap : <nop>
nnoremap ; :
vnoremap : <nop>
vnoremap ; :

" Make search and line jumps center of the screen
noremap G Gzz
noremap n nzz
noremap N Nzz
noremap } }zz
noremap { {zz

" }}}
" File types {{{

autocmd BufNewFile,BufReadPost,BufWritePost *.html.* set filetype=html
autocmd BufNewFile,BufReadPost,BufWritePost *.js.* set filetype=javascript

" }}}
" Search {{{

set gdefault
set hlsearch
set ignorecase
set incsearch
set showmatch
set smartcase

" Removes highlight of your last search
" *** See key binding for F3

" Keep search matches in the middle of the window.
nnoremap n nzzzv
nnoremap N Nzzzv

" Don't move on *
nnoremap * *<c-o>

" Open quickfix window for the last search result
if executable('ag')
    " Internal grep
    " Inspired by http://robots.thoughtbot.com/faster-grepping-in-vim/
    set grepprg=ag\ --nogroup\ --nocolor

    noremap <silent> <Leader>/ :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>
else
    noremap <silent> <Leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>
endif

" "Focus" the current line.
nnoremap <c-z> mzzMzvzz

" }}}
" Color theme & GUI {{{

Plugin 'chriskempson/base16-vim'
Plugin 'tomasr/molokai'
colorscheme molokai

" Adjust color theme for vim-javascript-syntax
autocmd ColorScheme * highlight javaScriptParens guifg=#b8b8b8
autocmd ColorScheme * highlight javaScriptEndColons guifg=#dc9656

" Show whitespace
" MUST be inserted AFTER the colors scheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=#ab4642
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

syntax on

set colorcolumn=+0
set t_Co=256

if has('gui_running')
    set background=dark
    colorscheme base16-eighties

    set guifont=Monaco\ for\ Powerline\ 11

    set guioptions-=m
    set guioptions-=T
    set guioptions-=r
    set guioptions-=L
    set guioptions-=b
    set guioptions+=c
endif

" }}}
" Formatting options {{{

set smartindent

set formatoptions=qrnlcoj
set formatoptions-=t
set textwidth=80

" Convert 4 space indentation to 2 spaces
function! g:Indent4to2()
    let s:view = winsaveview()

    try
        let _ts = &tabstop
        let _sts = &softtabstop

        set tabstop=4 softtabstop=4 noexpandtab
        retab!
        set tabstop=2 softtabstop=2 expandtab
        retab

        execute 'set tabstop=' . _ts . ' softtabstop=' . _sts
    finally
        call winrestview(s:view)
    endtry
endfunction

" Convert 2 space indentation to 4 spaces
function! g:Indent2to4()
    let s:view = winsaveview()

    try
        let _ts = &tabstop
        let _sts = &softtabstop

        set tabstop=2 softtabstop=2 noexpandtab
        retab!
        set tabstop=4 softtabstop=4 expandtab
        retab

        execute 'set tabstop=' . _ts . ' softtabstop=' . _sts
    finally
        call winrestview(s:view)
    endtry
endfunction

" }}}
" Folding {{{

" default marker based folding
augroup ft_marker
    autocmd!
    autocmd FileType twig setlocal foldmarker=[[[,]]]
    autocmd FileType javascript,vim,conf,css,sh,html,twig  setlocal foldmethod=marker
augroup END

nnoremap <Space> za
vnoremap <Space> za

" }}}
