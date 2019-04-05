"---- Settings ----"
set showcmd       " Show me what I'm typing
set number        " Show line numbers
set noswapfile    " Don't use swapfile
set nobackup      " Don't create annoying backup files
set incsearch     " Shows the match while typing
set hlsearch      " Highlight found searches
set ignorecase    " Search case insensitive...
set smartcase     " ... but not it begins with upper case
set tabstop=2     " tabs = 2 columns
set shiftwidth=2  " 2 columns identation keys
set expandtab     " tabs = spaces (youtube.com/watch?v=SsoOG6ZeyUI)
set laststatus=2  " Used by lightline
set shell=zsh
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
nnoremap <leader>r :Rg

" NERDTree toggle
map <C-t> :NERDTreeToggle<CR>

" Registers"
nnoremap <leader>x :registers<CR>

" Terminal "
nnoremap <leader>t :terminal<CR>

"---- Commands ----"

"-- ripgrep -- $ sudo apt install ripgrep"
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --line-number --no-heading --hidden --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
\ <bang>0)

"-- Closes vim when NERDTree is the only window left "
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"---- Plugins ----"

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
Plug 'terryma/vim-multiple-cursors'

call plug#end()

