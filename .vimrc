set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=UTF-8

if (has('termguicolors'))
  set termguicolors
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" General plugins
Plugin 'easymotion/vim-easymotion'
Plugin 'tomtom/tcomment_vim'
Plugin 'mhinz/vim-signify'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'preservim/nerdtree'
Plugin 'haya14busa/incsearch.vim'
Plugin 'vim-airline/vim-airline'

" Language specific plugins
Plugin 'mattn/emmet-vim'   " HTML expander
Plugin 'yuezk/vim-js'      " vim-js and vim-jsx-pretty are maintained by the same person
Plugin 'maxmellon/vim-jsx-pretty'
Plugin 'HerringtonDarkholme/yats.vim' " TS syntax file
Plugin 'prettier/vim-prettier' " Works for JS, TS, less, scss, css, json, graphql and markdown
Plugin 'fatih/vim-go'
" Plugin 'petrbroz/vim-glsl' " OpenGL
" Plugin 'elzr/vim-json'

" Colorscheme
Plugin 'kaicataldo/material.vim'

" Unused
" Plugin 'ryanoasis/vim-devicons' " Slow if I remember correctly
" Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Basic settings
syntax on
set background=dark
let g:material_theme_style = 'darker'
colorscheme material

set autoread
set cursorline
set incsearch
set hlsearch
set number
set noshowmode
set tabstop=4
set shiftwidth=4
set expandtab
vmap <Space> <Leader>
nmap <Space> <Leader>

" For convenient movement
nmap <silent> T zt
nnoremap <silent> <C-j> 4j
nnoremap <silent> <C-k> 4k
nnoremap <silent> <C-e> 4<C-e>
nnoremap <silent> <C-y> 4<C-y>
vnoremap <silent> <C-j> 4j
vnoremap <silent> <C-k> 4k
vnoremap <silent> <C-e> 4<C-e>
vnoremap <silent> <C-y> 4<C-y>

nnoremap <silent> <C-h> :tabprevious<CR>
nnoremap <silent> <C-l> :tabnext<CR>
nnoremap <silent> <C-w>mh :-tabmove<CR>
nnoremap <silent> <C-w>ml :+tabmove<CR>
nnoremap <silent> <C-f> :NERDTreeToggle<CR>

" Turn off highlight
nnoremap <silent> <C-c><C-c> :nohls<CR>
nnoremap <silent> i :nohls<CR>i

" For easy copy & paste
vnoremap <silent> <Leader>y "*y
vnoremap <silent> <Leader>p "*p
nnoremap <silent> <Leader>p "*p

" Allow number-line toggling, so that I can copy to system clipboard
nnoremap <silent> <C-n> :set number!<CR>:SignifyToggle<CR>

" Let Visual Block mode to persist after >, <
vnoremap < <gv
vnoremap > >gv
vnoremap // y/<C-R>"<CR>

" incsearch tuning
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" Easymotion tuning
nmap <Leader> <Plug>(easymotion-prefix)
nmap <Leader>l <Plug>(easymotion-lineforward)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
nmap <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" Let the searched item be highlighted in this color
hi Search ctermfg=59 guifg='#545454'
hi Search ctermbg=11 guibg='#ffcb6b'
" Navigation in Insert mode
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^

" Let Backspace work as intended
set backspace=indent,eol,start
nnoremap <BS> X

" Tab = 2 space for certain filetypes
autocmd FileType html setlocal ts=2 sw=2 expandtab
autocmd FileType javascript setlocal ts=2 sw=2 expandtab
autocmd FileType typescript setlocal ts=2 sw=2 expandtab

" YouCompleteMe setting
" Let clangd fully control code completion
let g:ycm_clangd_uses_ycmd_caching = 0
" Use installed clangd, not YCM-bundled clangd which doesn't get updates.
let g:ycm_clangd_binary_path = exepath("clangd")
" Close scratch buffer after completion
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_auto_hover = ''
nmap <Leader>d <plug>(YCMHover)

" NERDTree setting
let NERDTreeIgnore = ['__pycache__', '.git', '.circleci', '**/*.swp']
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeShowHidden = 1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" for OpenGL syntax highlighting
" autocmd! BufNewFile,BufRead *.vs,*.fs set ft=glsl

" emmet setting
let g:user_emmet_leader_key='<C-x>'

" Stop vim entering comments automatically upon enter
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
