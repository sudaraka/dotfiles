" .vimrc: Main configuration file for the VIM text editor
" Author: Sudaraka Wijesinghe <sudaraka.org/contact>
" Source: https://github.com/sudaraka/dotfiles/blob/master/vimrc
" License: CC-BY
"
" Inspired by https://bitbucket.org/sjl/dotfiles/src/tip/vim/vimrc
"

" Initialize {{{

" Enable vundle plugin manager
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

" Remove tabs and spaces from end of the lines
autocmd BufWritePre * :call <SID>remove_whitespace_trails()
function! <SID>remove_whitespace_trails()
    let _s=@/
    let l = line(".")
    let c = col(".")

    %s/\s\+$//e

    let@/=_s
    call cursor(l, c)
endfunction

" Resize splits when the window is resized
autocmd VimResized * :wincmd =

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

" Sub-routines for Django testing with in Vim {{{
let g:django_test_module = ''

" Run the test on module stored in global variable
" (Run all the tests when module name is blank)
function! g:Django_run_test()
    if filereadable('manage.py')
        execute '!./manage.py test ' . g:django_test_module
    endif
endfunction

" Show coverage report
function! g:Django_coverage_report()
    !coverage report -m
endfunction

" Run test to gather coverage data
function! g:Django_coverage_run()
    if filereadable('manage.py')
        !coverage run ./manage.py test
    endif
endfunction

" Run test with module name set based on the current file
function! g:Django_run_test_module()
    if 0  == match(expand('%:t:h'), 'test_')
        let g:django_test_module = substitute(fnamemodify(@%, ':r'), '/', '.', 'g')

        call g:Django_run_test()
    endif
endfunction

" Clear global test module name
function! g:Django_clear_test_module()
    let g:django_test_module = ''
endfunction

" }}}

" }}}
" Basic settings {{{

filetype off
filetype plugin indent on

set autoindent
set autoread
set cursorline
set hidden
set lazyredraw
set linebreak
set nobackup
set nocompatible
set norelativenumber
set noswapfile
set nowrap
set nowritebackup
set number
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
set fileencoding=utf-8
set fileformat=unix
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set modelines=0
set showbreak=↪
set termencoding=utf-8
set mouse-=a

" }}}
" Key bindings {{{

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

" F2: show hide non-printable characters
noremap <F2> :set list!<CR>:call indent_guides#toggle()<CR>

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

" F9: run current file in shell
noremap <silent> <F9> :!./%<CR>

" Ctrl+F4: close current buffer using bd
noremap <silent> <C-F4> :bd<CR>

" Ctrl+Shift+F4: close all buffers using bd
noremap <silent> <C-S-F4> :1,9999bd<CR>

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

" Easier linewise reselection of what you just pasted.
nnoremap <leader>v V`]

" Case conversions
inoremap <C-u> <esc>gUiwea
nnoremap <C-u> gUiw
vnoremap <C-u> gU
inoremap <C-l> <esc>guiwea
nnoremap <C-l> guiw
vnoremap <C-l> gu

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

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

" quick type assistance for pairs
inoremap <leader>' ''<esc>i
inoremap <leader>" ""<esc>i
inoremap <leader>( ()<esc>i
inoremap <leader>[ []<esc>i
inoremap <leader>{ {}<esc>i
inoremap <leader>< <><esc>i
inoremap <leader><? <?php  ?><esc>2hi

" quick type assistance for ending semicolon
inoremap <leader>;  <esc>A;

" Key binding for running Django test using default module value
nnoremap <silent> <Leader>dt :call g:Django_run_test()<CR>
vnoremap <silent> <Leader>dt <esc>:call g:Django_run_test()<CR>

" Key binding for running set module name and run Django test
nnoremap <silent> <Leader>dT :call g:Django_run_test_module()<CR>
vnoremap <silent> <Leader>dT <esc>:call g:Django_run_test_module()<CR>

" Key binding for clearing the global Django test module
nnoremap <silent> <Leader>dx :call g:Django_clear_test_module()<CR>
vnoremap <silent> <Leader>dx <esc>:call g:Django_clear_test_module()<CR>

" Key binding for running coverage command for Django testing
noremap <silent> <Leader>dc :call g:Django_coverage_report()<CR>
vnoremap <silent> <Leader>dc <esc>:call g:Django_coverage_report()<CR>
nnoremap <silent> <Leader>dC :call g:Django_coverage_run()<CR>
vnoremap <silent> <Leader>dC <esc>:call g:Django_coverage_run()<CR>

" }}}
" File types {{{

autocmd BufNewFile,BufRead,BufWritePost *.md set filetype=markdown
autocmd BufNewFile,BufRead,BufWritePost *.json,*.webapp set filetype=json
autocmd BufNewFile,BufRead,BufWritePost *.js.* set filetype=javascript

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

Bundle 'tomasr/molokai'
colorscheme molokai

" Show whitespace
" MUST be inserted BEFORE the colors scheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
autocmd InsertLeave * match ExtraWhitespace /\s\+$/

" Highlight VCS conflict markers
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

syntax on

set colorcolumn=+0
set t_Co=256

if has('gui_running')
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

set expandtab
set smartindent

set formatoptions=qrnlcoj
set formatoptions-=t
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=80

" Convert 4 space indentation to 2 spaces
function! g:Indent4to2()
    let _s=@/
    let l = line(".")
    let c = col(".")

    let _ts = &tabstop
    let _sts = &softtabstop

    set tabstop=4 softtabstop=4 noexpandtab
    retab!
    set tabstop=2 softtabstop=2 expandtab
    retab

    execute 'set tabstop=' . _ts . ' softtabstop=' . _sts

    let@/=_s
    call cursor(l, c)
endfunction

" Convert 2 space indentation to 4 spaces
function! g:Indent2to4()
    let _s=@/
    let l = line(".")
    let c = col(".")

    let _ts = &tabstop
    let _sts = &softtabstop

    set tabstop=2 softtabstop=2 noexpandtab
    retab!
    set tabstop=4 softtabstop=4 expandtab
    retab

    execute 'set tabstop=' . _ts . ' softtabstop=' . _sts

    let@/=_s
    call cursor(l, c)
endfunction

" }}}
" Folding {{{

" default marker based folding
augroup ft_marker
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
    autocmd FileType javascript setlocal foldmethod=marker
    autocmd FileType css setlocal foldmethod=marker
    autocmd FileType sh setlocal foldmethod=marker
    autocmd FileType twig setlocal foldmarker=[[[,]]]
    autocmd FileType twig setlocal foldmethod=marker
augroup END

nnoremap <Space> za
vnoremap <Space> za

" }}}
" Programing environments {{{

" Plugin: Splice {{{

Bundle 'sjl/splice.vim'

" }}}
" Plugin: Vim-Indent-Guides {{{

Bundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_guide_size=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors = 1

" }}}
" Plugin: CtrlP {{{

Bundle 'kien/ctrlp.vim'
let g:ctrlp_max_height = 30
set wildignore+=*.pyc

" Use Silver Search CtrlP
" Inspired by http://robots.thoughtbot.com/faster-grepping-in-vim/
if executable('ag')
    let g:ctrlp_user_command = 'ag %s -l --nocolor -U --hidden -g "" --ignore *.pyc --ignore .git --ignore .ropeproject --ignore .virtualenv --ignore __pycache__'
    let g:ctrlp_use_caching = 0
endif


" }}}
" Pligin: Nerdcommenter {{{

Bundle 'scrooloose/nerdcommenter'

"}}}
" Plugin: Vim-Fugitive {{{

Bundle 'tpope/vim-fugitive'

"}}}
" Plugin: Vim-Airline {{{

" Symlink a patched font
"   sudo ln -s ~/.vim/bundle/powerline-fonts/DejaVuSansMono/DejaVu\ Sans\ Mono\ for\ Powerline.ttf /usr/share/fonts/TTF
Bundle 'bling/vim-airline'
Bundle 'Lokaltog/powerline-fonts'
set laststatus=2
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#tabline#enabled = 1
if has('gui_running')
    let g:airline_powerline_fonts = 1
endif

"}}}
" Plugin: Syntastic {{{

Bundle 'scrooloose/syntastic'

"}}}

" Language: HTML/CSS {{{

" Plugin: Color Highlight {{{

Bundle 'chrisbra/color_highlight'
let g:colorizer_auto_filetype='css,html,rc,conf,tpl,xml,ini'

" }}}
" Plugin: Vim-CSS3-Syntax {{{

Bundle 'hail2u/vim-css3-syntax'

" }}}
" Plugin: Vim-Twig {{{

Bundle 'evidens/vim-twig'

"}}}
" Plugin: Emmet-Vim {{{

Bundle 'mattn/emmet-vim'
let g:user_emmet_mode = 'ni'

"}}}

" }}}
" Language: JavaScript {{{

" Plugin: Vim-JavaScript {{{
" for JavaScript syntax highlighting

Bundle 'pangloss/vim-javascript'

let javascript_enable_domhtmlcss = 1
let b:javascript_fold = 1
let g:javascript_conceal = 1

"}}}
" Plugin: JSHint2 {{{
" for JavaScript syntax checking

Bundle 'shutnik/jshint2.vim'

let jshint2_read = 1
let jshint2_save = 1
let jshint2_color = 1

"}}}
" Plugin: Vim-JSON {{{

Bundle 'elzr/vim-json'

let g:vim_json_syntax_conceal = 0

"}}}

" }}}
" Language: PHP {{{

" Plugin: Phpfolding {{{

Bundle 'rayburgemeestre/phpfolding.vim'

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
    retab

    let@/=_s
    call cursor(l, c)
endfunction

" }}}
" Language: Python {{{

" Plugin: Python-Mode {{{

Bundle 'klen/python-mode'

map <Leader>g :call RopeGotoDefinition()<CR>

let g:pymode_lint_unmodified = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe', 'pylint']

" Ignore certain errors/warnings
"   F0401 - module import failures - when editing a Django app that runs in a
"   virtual environment this show lot of errors.
let g:pymode_lint_ignore = 'F0401'

map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

" }}}

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
set completeopt=longest,menuone
function! OmniPopup(action)
    if pumvisible()
       if a:action == 'j'
            return "\<C-N>"
       elseif a:action == 'k'
            return "\<C-P>"
       endif
    endif
    return a:action
endfunction

inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>

" }}}

" }}}
" Presentation {{{

Bundle 'presenting.vim'

" }}}
