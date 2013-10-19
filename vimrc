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

" Save when losing focus
autocmd FocusLost * :silent! wall

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

" }}}
" Basic settings {{{

filetype off
filetype plugin indent on

set autoindent
set autoread
set autowrite
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

" }}}
" Key bindings {{{

" Disable arrow key navigation
noremap <Up> ""
noremap <Down> ""
noremap <Left> ""
noremap <Right> ""
noremap! <Up> <Esc>
noremap! <Down> <Esc>
noremap! <Left> <Esc>
noremap! <Right> <Esc>

" Rebind <Leader> key
let mapleader = ","

" F2: show hide non-printable characters
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


" Ctrl+S: save all buffers
nnoremap <silent> <C-s> :wa<CR>
inoremap <silent> <C-s> <C-o>:wa<CR>
vnoremap <silent> <C-s> <C-c>:wa<CR>

" Better copy & paste
set clipboard=unnamed
noremap <Leader>y "+yy
vnoremap <Leader>y "+yy
inoremap <Leader>y <C-o>"+yya
noremap <Leader>p "+p
noremap <Leader><S-p> "+P

" Ctrl+PgUP/Down: buffer switching within the window
noremap <silent> <C-PageUp> :bn<CR>
noremap <silent> <C-PageDown> :bp<CR>

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
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation

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
nnoremap <C-u> gUiw
inoremap <C-u> <esc>gUiwea

" Sudo to write
cnoremap w!! w !sudo tee % >/dev/null

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
noremap <silent> <Leader>/ :execute 'vimgrep /'.@/.'/g %'<CR>:copen<CR>

" "Focus" the current line.
nnoremap <c-z> mzzMzvzz

" }}}
" Color theme & GUI {{{

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
    set guifont=Droid\ Sans\ Mono\ Regular\ 10

    set guioptions-=m
    set guioptions-=T
    set guioptions+=bhc
endif

" Installing wombat256 color theme:
" mkdir -p ~/.vim/colors
" wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400
colorscheme wombat256mod

" Manual overrides for color theme
highlight ColorColumn   ctermbg=240                                                 guibg=#463535
highlight CursorLine                                                                gui=bold
highlight LineNr		ctermfg=179		ctermbg=none	cterm=none	guifg=#857b6f	guibg=#080808	gui=none
highlight Normal		ctermfg=252		ctermbg=none	cterm=none	guifg=#e3e0d7	guibg=#080808	gui=none

" }}}
" Tabs and spaces {{{

set expandtab
set smartindent

set formatoptions=qrnl
set shiftwidth=4
set softtabstop=4
set tabstop=4
set textwidth=80

" }}}
" Folding {{{

" default marker based folding
augroup ft_marker
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END

nnoremap <Space> za
vnoremap <Space> za

" }}}
" Programing environments {{{

" Plugin: CtrlP {{{

Bundle 'kien/ctrlp.vim'
let g:ctrlp_max_height = 30
set wildignore+=*.pyc

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
let g:airline#extensions#tabline#enabled = 1
if has('gui_running')
    let g:airline_powerline_fonts = 1
endif

"}}}
" Plugin: Vim-Surround {{{

Bundle 'tpope/vim-surround'

" }}}

" Language: HTML/CSS {{{

" Plugin: Color Highlight {{{

Bundle 'chrisbra/color_highlight'
let g:colorizer_auto_filetype='css,html,rc,conf,tpl,xml'

" }}}
" Plugin: Vim-CSS3-Syntax {{{

Bundle 'hail2u/vim-css3-syntax'

" }}}

" }}}
" Language: PHP {{{

" Plugin: Phpfolding {{{

Bundle 'vim-scripts/phpfolding.vim'

"}}}
" Plugin: Syntastic {{{

Bundle 'scrooloose/syntastic'

"}}}
" Plugin: Vim-Twig {{{

Bundle 'evidens/vim-twig'

"}}}

" Auto (Omni) complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>

" }}}
" Language: Python {{{

" Plugin: Python-Mode {{{

Bundle 'klen/python-mode'
", {'master': '1b4b8f1'}
map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1

let g:pymode_rope = 1
let g:pymode_rope_extended_complete = 1
let g:pymode_rope_goto_def_newwin = "vnew"

let g:pymode_breakpoint = 0

let g:pymode_syntax = 1
let g:pymode_syntax_builtin_funcs = 0
let g:pymode_syntax_builtin_objs = 0

let g:pymode_folding = 1

let g:pymode_virtualenv = 1

let g:pymode_lint = 1
let g:pymode_lint_checker = "pyflakes,pep8,mccabe"
let g:pymode_lint_cwindow = 1
let g:pymode_lint_maxheight = 6
let g:pymode_lint_signs = 1
let g:pymode_lint_write = 1

let g:pymode_run = 1

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
