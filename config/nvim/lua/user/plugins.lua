local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}


-- Closes vim when NERDTree is the only window left
vim.cmd [[
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
]]

-- Setting to automatically remove trailing whitespace when saving a file
vim.cmd [[
  autocmd BufWritePre * :%s/\s\+$//e
]]

-- Function to show relative file name from git root
vim.cmd [[
function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
]]

-- Auto align on tables using `|`
vim.cmd [[
function! s:align()
  let p = '^\s*|\s.*\s|\s*$'
  if exists(':Tabularize') && getline('.') =~# '^\s*|' && (getline(line('.')-1) =~# p || getline(line('.')+1) =~# p)
    let column = strlen(substitute(getline('.')[0:col('.')],'[^|]','','g'))
    let position = strlen(matchstr(getline('.')[0:col('.')],'.*|\s*\zs.*'))
    Tabularize/|/l1
    normal! 0
    call search(repeat('[^|]*|',column).'\s\{-\}'.repeat('.',position),'ce',line('.'))
  endif
endfunction
]]

vim.cmd [[
let g:lightline = {
  \   'colorscheme': 'nord',
  \   'component_function': {
  \     'filename': 'LightlineFilename',
  \   }
  \ }
]]

vim.cmd [[
  let g:highlightedyank_highlight_duration = 300
]]

vim.cmd [[
  augroup lsp
    au!
    au FileType java,scala,sbt lua require("metals").initialize_or_attach({})
  augroup end
]]

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins
  use {"junegunn/fzf", dir = "~/.fzf", run = "yes | ./install" }
  use "junegunn/fzf.vim"
  use "itchyny/lightline.vim"
  use "scrooloose/nerdtree"
  use "tpope/vim-surround"
  use "tpope/vim-fugitive"
  use "godlygeek/tabular"
  use "morhetz/gruvbox"
  use "arcticicestudio/nord-vim"
  use "machakann/vim-highlightedyank"
  use "sheerun/vim-polyglot"
  use "ap/vim-css-color"
  use "junegunn/goyo.vim"
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  -- cmp plugins
  use "hrsh7th/nvim-cmp" -- The completion plugin
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"

  use {'goolord/alpha-nvim', requires = { 'kyazdani42/nvim-web-devicons' }}

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer

  -- scalameta
  use {'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }}


  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
