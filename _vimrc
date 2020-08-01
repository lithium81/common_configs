" ---------------------------------
" vim run commands (rc)
" last modified: 2020/08/01
" Jaeha Kim, <lithium81@gmail.com>
" ---------------------------------

" ---------------------------------
" Prerequisites
" ---------------------------------
" uses vim's improved feature, instead of preserving compatibility with old vi
set nocompatible


" ---------------------------------
"  Vim Bundle (Vundle)
" ---------------------------------
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" My Bundles
Plugin 'scrooloose/nerdtree'
Plugin 'SrcExpl'
Plugin 'taglist.vim'
Plugin 'AutoComplPop'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'frazrepo/vim-rainbow'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'

call vundle#end()
filetype plugin indent on


" ---------------------------------
" Important common settings 
" ---------------------------------
if has("syntax")
    syntax on
endif

set incsearch
set hlsearch
set number
set tabstop=4
set softtabstop=4
set shiftwidth=4

set cindent
set autoindent
set smartindent

set showmatch
set smartcase
set smarttab
set expandtab

set title
set ruler

" Encoding
set encoding=utf-8
set fileencodings=utf-8,euc-kr,cp949

" Key re-map for easy window navigation, use arrows
nmap <C-Left> <C-w>h
nmap <C-Up> <C-w>j
nmap <C-Down> <C-w>k
nmap <C-Right> <C-w>l

" rc management
let mapleader=","
nmap <Leader>rc :rightbelow vnew $MYVIMRC<CR>


" ---------------------------------
" Display 
" ---------------------------------

" colorscheme
colorscheme elflord 

" vim-airline
let g:airline#extension#tabline#enabled = 1
let g:airline_theme='hybrid'
set laststatus=2


" ---------------------------------
" Specific configuration for each plugin 
" ---------------------------------
" NERDTree
let NERDTreeWinPos = "left"
nmap <F7> :NERDTreeToggle<CR>

" ctag and Tag list
set tags=./tags,tags
set tags+=../tags
"set tags+=/usr/src/linux/tags
set tagbsearch
let Tlist_Use_Right_Window = 1
nmap <F8> :Tlist<CR>

" SrcExpl
let g:SrcExpl_winHeight = 8
let g:SrcExpl_refreshTime = 100
nmap <F9> :SrcExplToggle<CR><CR>

" Rainbow
let g:rainbow_active = 1

