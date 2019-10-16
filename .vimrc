set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

Plugin 'easymotion/vim-easymotion'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'tomasiser/vim-code-dark'
Plugin 'airblade/vim-gitgutter'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'haya14busa/incsearch.vim'
Plugin 'fs111/pydoc.vim'
Plugin 'vim-airline/vim-airline'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" Basic settings
syntax on
colorscheme codedark
set incsearch
set hlsearch
set number

" For convenient movement
nnoremap <silent> <c-j> 4j
nnoremap <silent> <c-k> 4k
nnoremap <silent> <C-h> :tabprevious<CR>
nnoremap <silent> <C-l> :tabnext<CR>

" Allow number-line toggling, so that I can copy to system clipboard
nnoremap <silent> <c-n> :set number!<CR>:GitGutterToggle<CR>
nmap <silent> T <c-k>zt<c-j>

" Let Visual Block mode to persist after >, <
vnoremap < <gv
vnoremap > >gv
vnoremap // y/<C-R>"<CR>
nnoremap i :nohls<CR>i

" Easymotion tuning
nmap <Space> <leader>
nmap <Leader> <Plug>(easymotion-prefix)
nmap <Leader>l <Plug>(easymotion-lineforward)
nmap <Leader>j <Plug>(easymotion-j)
nmap <Leader>k <Plug>(easymotion-k)
nmap <Leader>h <Plug>(easymotion-linebackward)
let g:EasyMotion_startofline = 0 " keep cursor column when JK motion

" Activate NERDTree when vim starts
autocmd vimenter * NERDTree

" Let the searched item be highlighted in this color
hi Search ctermbg=24

" Navigation in Insert mode
inoremap <c-e> <c-o>$
inoremap <c-a> <c-o>^
inoremap <c-h> <Left> 
inoremap <c-j> <Down>
inoremap <c-k> <Up>
inoremap <c-l> <Right>

" Let Backspace work as intended
set backspace=indent,eol,start
nnoremap <BS> X

