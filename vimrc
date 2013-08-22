" Default character encoding
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8


" Enable syntax highlighting
" You need to reload this file for the change to apply
filetype off
filetype plugin indent on
syntax on


"Enable Vundle plugin manager
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'


" Automatic reloading of .vimrc
autocmd! bufwritepost .vimrc source %

autocmd BufWritePre * :call <SID>remove_whitespace_trails()
" Remove tabs and spaces from end of the lines
function! <SID>remove_whitespace_trails()
	let _s=@/
	let l = line(".")
	let c = col(".")

	%s/\s\+$//e

	let@/=_s
	call cursor(l, c)
endfunction


" Rebind <Leader> key
" I like to have it here because it is easier to reach than the default and
" it is next to ``m`` and ``n`` which I use for navigating between tabs.
let mapleader = ","


" Better copy & paste
set clipboard=unnamed
noremap <Leader>y "+yy
vnoremap <Leader>y "+yy
inoremap <Leader>y <Esc>"+yya

noremap <Leader>p "+p
noremap <Leader><S-p> "+P

" Map buffer navigation to Ctrl+PgUP/Down
noremap <C-PageUp> :bn<CR>
noremap <C-PageDown> :bp<CR>

" Bind nohl
" Removes highlight of your last search
noremap <F3> :nohl<CR>
vnoremap <F3> :nohl<CR>
inoremap <F3> :nohl<CR>


" Quicksave command
noremap <C-Z> :wa<CR>
vnoremap <C-Z> <C-C>:wa<CR>
inoremap <C-Z> <C-O>:wa<CR>


set listchars=tab:<>,eol:¬

" bind Ctrl+<movement> keys to move around the windows, instead of using Ctrl+w + <movement>
" Every unnecessary keystroke that can be saved is good for your health :)
map <c-j> <c-w>j
map <c-k> <c-w>k
map <c-l> <c-w>l
map <c-h> <c-w>h


" easier moving between tabs
map <Leader>m <esc>:bp<CR>
map <Leader>. <esc>:bn<CR>


" map sort function to a key
vnoremap <Leader>s :sort<CR>


" easier moving of code blocks
vnoremap < <gv  " better indentation
vnoremap > >gv  " better indentation


" Show whitespace
" MUST be inserted BEFORE the colors scheme command
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
au InsertLeave * match ExtraWhitespace /\s\+$/



" Color scheme
" mkdir -p ~/.vim/colors
" wget -O ~/.vim/colors/wombat256mod.vim http://www.vim.org/scripts/download_script.php?src_id=13400

set t_Co=256
set cursorline
color wombat256mod

" Manual overrides for color theme
hi Normal		ctermfg=252		ctermbg=none	cterm=none		guifg=#e3e0d7	guibg=#080808	gui=none
hi LineNr		ctermfg=179		ctermbg=none	cterm=none		guifg=#857b6f	guibg=#080808	gui=none
hi CursorLine					                                                                gui=bold


set guifont=Droid\ Sans\ Mono\ Regular\ 10
set guioptions-=m
set guioptions-=T
set guioptions+=bhc


" Showing line numbers and length
set number  " show line numbers
set textwidth=79   " width of document (used by gd)
set nowrap  " don't automatically wrap on load
set fo-=t   " don't automatically wrap text when typing
set colorcolumn=80
set smartindent
highlight ColorColumn ctermbg=240 guibg=#463535

set spell


" easier formatting of paragraphs
vmap Q gq
nmap Q gqap



" Real programmers don't use TABs but spaces
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set expandtab


" Make search case insensitive
set hlsearch
set incsearch
set ignorecase
set smartcase


" Disable stupid backup and swap files - they trigger too many events
" for file system watchers
set nobackup
set nowritebackup
set noswapfile



" ============================================================================
" Generic IDE Setup
" ============================================================================

" Settings for powerline
" https://github.com/Lokaltog/powerline
" Symlink a patched font
"   sudo ln -s ~/.vim/bundle/powerline-fonts/DejaVuSansMono/DejaVu\ Sans\ Mono\ for\ Powerline.ttf /usr/share/fonts/TTF
Bundle 'Lokaltog/powerline'
Bundle 'Lokaltog/powerline-fonts'
set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
set laststatus=2

" Code comment helper
" https://github.com/scrooloose/nerdcommenter
Bundle 'scrooloose/nerdcommenter'

" Surround: easily manipulate surrounding tags/braces
" https://github.com/tpope/vim-surround
Bundle 'tpope/vim-surround'


" ============================================================================
" PHP IDE Setup
" ============================================================================

" Syntax checking
" https://github.com/tomtom/checksyntax_vim
"Bundle 'tomtom/checksyntax_vim'
" https://github.com/scrooloose/syntastic
Bundle 'scrooloose/syntastic'

" Twig (for Symfony) syntax highlight
Bundle 'evidens/vim-twig'

" Auto (Omni) complete
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
\ "\<lt>C-n>" :
\ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
\ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
\ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>


" ============================================================================
" Python IDE Setup
" ============================================================================

" Settings for ctrlp
" cd ~/.vim/bundle
" https://github.com/kien/ctrlp.vim
Bundle 'kien/ctrlp.vim'
let g:ctrlp_max_height = 30
set wildignore+=*.pyc
"" set wildignore+=*_build/*
"" set wildignore+=*/coverage/*


" Settings for python-mode
" cd ~/.vim/bundle
" git clone https://github.com/klen/python-mode
Bundle 'klen/python-mode'
map <Leader>g :call RopeGotoDefinition()<CR>
let ropevim_enable_shortcuts = 1
let g:pymode_rope_goto_def_newwin = "vnew"
let g:pymode_rope_extended_complete = 1
let g:pymode_breakpoint = 0
let g:pymode_syntax = 1
let g:pymode_syntax_builtin_objs = 0
let g:pymode_syntax_builtin_funcs = 0
let g:pymode_folding = 0
map <Leader>b Oimport ipdb; ipdb.set_trace() # BREAKPOINT<C-c>

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


" ============================================================================
" HTML/CSS IDE Setup
" ============================================================================

" Zen coding
" https://github.com/mattn/zencoding-vim
"Bundle 'mattn/zencoding-vim'

" Color highlight
" https://github.com/chrisbra/color_highlight.git
Bundle 'chrisbra/color_highlight'
let g:colorizer_auto_filetype='css,html,rc,conf,tpl,xml'

" CSS3 syntax highlight
" https://github.com/hail2u/vim-css3-syntax
Bundle 'hail2u/vim-css3-syntax'

" LESS compiler
" https://github.com/groenewege/vim-less
" Requires LESS compiler (lessc) and node.js
"Bundle 'groenewege/vim-less'

