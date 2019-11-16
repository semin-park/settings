set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'easymotion/vim-easymotion'
Plugin 'tomtom/tcomment_vim'
Plugin 'mhinz/vim-signify'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'haya14busa/incsearch.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'nvie/vim-flake8'
Plugin 'morhetz/gruvbox'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Basic settings
syntax on
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_invert_selection=0

set background=dark

set cursorline
set incsearch
set hlsearch
set number
set noshowmode
set tabstop=4
set shiftwidth=4
set expandtab

" For convenient movement
nnoremap <silent> <C-d> 10<C-d>
nnoremap <silent> <C-u> 10<C-u>
nnoremap <silent> <C-j> 4j
nnoremap <silent> <C-k> 4k
nnoremap <silent> <C-e> 4<C-e>
nnoremap <silent> <C-y> 4<C-y>
nnoremap <silent> <C-h> :tabprevious<CR>
nnoremap <silent> <C-l> :tabnext<CR>
nnoremap <silent> <C-c><C-c> :nohls<CR>
nnoremap <silent> <C-w>mh :-tabmove<CR>
nnoremap <silent> <C-w>ml :+tabmove<CR>
nnoremap <silent> i :nohls<CR>i
nnoremap <silent> <C-f> :NERDTreeToggle<CR>
nmap <silent> T <C-k>zt<C-j>

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
nmap <Space> <leader>
nmap <Leader> <Plug>(easymotion-prefix)
nmap <Leader>l <Plug>(easymotion-lineforward)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
nmap <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" Let the searched item be highlighted in this color
hi Search ctermbg=24
" Navigation in Insert mode
inoremap <C-e> <C-o>$
inoremap <C-a> <C-o>^
inoremap <C-h> <Left> 
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

" Let Backspace work as intended
set backspace=indent,eol,start
nnoremap <BS> X
