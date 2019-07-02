"---- Settings ----"
set showcmd            " Show me what I'm typing
set number             " Show line numbers
set noswapfile         " Don't use swapfile
set nobackup           " Don't create annoying backup files
set incsearch          " Shows the match while typing
set hlsearch           " Highlight found searches
set ignorecase         " Search case insensitive...
set smartcase          " ... but not it begins with upper case
set tabstop=2          " tabs = 2 columns
set shiftwidth=2       " 2 columns identation keys
set expandtab          " tabs = spaces (youtube.com/watch?v=SsoOG6ZeyUI)
set laststatus=2       " Used by lightline
set shell=zsh          " Oh my sweet shell
set diffopt+=vertical  " Fugitive Gdiff

" colorscheme focuspoint
"hi Normal guibg=NONE ctermbg=NONE

"---- Mappings ----"

let mapleader = ","

" fzf
nnoremap <leader><leader> :Files<CR>

" buffers
nnoremap <leader><Enter> :Buffers<CR>

" Tabs
nnoremap <leader>w :Windows<CR>

" commits of file
nnoremap <leader>c :BCommits<CR>

" ripgrep "
nnoremap <leader>r :Rg<space>

" NERDTree toggle
map <C-t> :NERDTreeToggle<CR>

" Registers"
nnoremap <leader>x :registers<CR>

" Terminal "
nnoremap <leader>t :terminal<CR>

" don't highlight next search and clear the window
nnoremap <C-l> :nohlsearch<CR><C-l>

" toggle Rainbow Highlight
nnoremap <C-]> :RainbowToggle<CR><C-l>

" easier window navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

"---- Commands ----"

"-- Closes vim when NERDTree is the only window left "
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"-- Auto install -- $ sudo apt install curl"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

"- FZF -"
let g:fzf_install = 'yes | ./install'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': g:fzf_install }
Plug 'junegunn/fzf.vim'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

"- lightline -"
Plug 'itchyny/lightline.vim'
let g:lightline = {'colorscheme': 'jellybeans'}
" TODO improve lightline formating

"- NERDTree -"
Plug 'scrooloose/nerdtree'

"- Vim Surround-"
Plug 'tpope/vim-surround'

"- Fugitive -"
Plug 'tpope/vim-fugitive'

"- Multiple Cursors -"
"Plug 'terryma/vim-multiple-cursors'

"- Same color Open/Close brackets/parenthesis/squareBrackets
Plug 'luochen1990/rainbow'

"- Directories Diff -"
Plug 'will133/vim-dirdiff'

" https://github.com/chase/focuspoint-vim
Plug 'chase/focuspoint-vim'

call plug#end()

