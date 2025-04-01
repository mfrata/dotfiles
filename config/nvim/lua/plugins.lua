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

vim.api.nvim_create_autocmd("FileType", {
	pattern = "Avante",
	callback = function()
		vim.api.nvim_set_hl(0, "AvanteSidebarNormal", { link = "Normal" })
		vim.api.nvim_set_hl(0, "AvanteSidebarWinSeparator", { link = "WinSeparator" })

		local normal_bg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg)
		vim.api.nvim_set_hl(0, "AvanteSidebarWinHorizontalSeparator", { fg = normal_bg })
	end,
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use {"junegunn/fzf", dir = "~/.fzf", run = "yes | ./install" }
  use "itchyny/lightline.vim"
  use "scrooloose/nerdtree"
  use "tpope/vim-surround"
  use "tpope/vim-fugitive"
  use "morhetz/gruvbox"
  use "machakann/vim-highlightedyank"
  use "sheerun/vim-polyglot"
  use "ap/vim-css-color"
  use "junegunn/goyo.vim"
  use {'iamcco/markdown-preview.nvim', run = 'cd app && yarn install', cmd = 'MarkdownPreview'}

  use {
      'VonHeikemen/lsp-zero.nvim',
      branch = 'v1.x',
      requires = {
    	  -- LSP Support
    	  {'neovim/nvim-lspconfig'},
    	  {'williamboman/mason.nvim'},
    	  {'williamboman/mason-lspconfig.nvim'},

    	  -- Autocompletion
    	  {'hrsh7th/nvim-cmp'},
    	  {'hrsh7th/cmp-buffer'},
    	  {'hrsh7th/cmp-path'},
    	  {'saadparwaiz1/cmp_luasnip'},
    	  {'hrsh7th/cmp-nvim-lsp'},
    	  {'hrsh7th/cmp-nvim-lua'},

    	  -- Snippets
    	  {'L3MON4D3/LuaSnip'},
    	  {'rafamadriz/friendly-snippets'},
      }
  }

  use {
    'yetone/avante.nvim',
    branch = 'main',
    run = 'make',
    opts = {
      provider = 'openai',
      openai = {
        model = "gpt-4o",
        temperature = 0,
      },
    },
    requires = {
      {'nvim-treesitter/nvim-treesitter'},
      {'stevearc/dressing.nvim'},
      {'nvim-lua/plenary.nvim'},
      {'MunifTanjim/nui.nvim'},
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
      {'hrsh7th/nvim-cmp'},
      {'nvim-tree/nvim-web-devicons'},
      {'HakonHarnes/img-clip.nvim'},
      {'zbirenbaum/copilot.lua'},
    },
    config = function()
      require('avante').setup()
    end
  }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
