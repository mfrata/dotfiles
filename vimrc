"---- Settings ----"

set showcmd            " Show me what I'm typing
set number             " Show line numbers
set noswapfile         " Don't use swapfile
set nobackup           " Don't create annoying backup files
set incsearch          " Shows the match while typing
set hlsearch           " Highlight found searches
set ignorecase         " Search case insensitive...
set smartcase          " ... but not if begins with upper case
set tabstop=2          " tabs = 2 columns
set shiftwidth=2       " 2 columns identation keys
set expandtab          " tabs = spaces (youtube.com/watch?v=SsoOG6ZeyUI)
set laststatus=2       " Used by lightline
set shell=zsh          " Oh my sweet shell
set diffopt+=vertical  " Fugitive Gdiff
set relativenumber     " Relative line number

colorscheme focuspoint


"---- Mappings ----"

let mapleader = ","

" fzf search
nnoremap <leader><leader> :Files<CR>

" Buffers
nnoremap <leader><Enter> :Buffers<CR>

" Tabs
nnoremap <leader>w :Windows<CR>

" Commits of file
nnoremap <leader>c :BCommits<CR>

" ripgrep "
nnoremap <leader>r :Rg<space>

" NERDTree toggle
map <C-t> :NERDTreeToggle<CR>

" Registers"
nnoremap <leader>x :registers<CR>

" Terminal "
nnoremap <leader>t :terminal<CR>

" Don't highlight next search and clear the window
nnoremap <C-l> :nohlsearch<CR><C-l>

" Toggle Rainbow Highlight
nnoremap <C-]> :RainbowToggle<CR><C-l>

" Easier window navigation
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" Disable Arrow keys in Escape mode
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>

" Disable Arrow keys in Insert mode
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>


"---- Commands ----"

"-- Closes vim when NERDTree is the only window left "
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"-- Auto install -- $ sudo apt install curl"
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" install focuspoint color theme
if empty(glob('~/.vim/colors/focuspoint.vim'))
  silent !curl -fLo ~/.vim/colors/focuspoint.vim --create-dirs
    \ https://raw.githubusercontent.com/chase/focuspoint-vim/master/colors/focuspoint.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Function to show relative file name from git root
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction


"---- Plugins configs ----"

let g:fzf_install = 'yes | ./install'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:lightline = {
  \   'colorscheme': 'jellybeans',
  \   'component_function': {
  \     'filename': 'LightlineFilename',
  \   }
  \ }


"---- Plugins ----"

call plug#begin('~/.vim/bundle')

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': g:fzf_install }
Plug 'junegunn/fzf.vim'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'chase/focuspoint-vim'

call plug#end()
