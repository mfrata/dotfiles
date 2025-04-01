return {
  -- UI
  { "itchyny/lightline.vim" },
  { "morhetz/gruvbox" },
  { "machakann/vim-highlightedyank" },
  { "sheerun/vim-polyglot" },
  { "ap/vim-css-color" },
  { "junegunn/goyo.vim" },

  -- File navigation and fuzzy finder
  {
    "junegunn/fzf",
    build = "./install --all",
  },
  {
    "junegunn/fzf.vim",
    dependencies = { "junegunn/fzf" },
  },
  { "scrooloose/nerdtree" },

  -- Git
  { "tpope/vim-fugitive" },

  -- Editing enhancements
  { "tpope/vim-surround" },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && yarn install",
    cmd = "MarkdownPreview",
  },

  -- LSP & Autocompletion
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "L3MON4D3/LuaSnip" },

  -- Avante (AI plugin)
  {
    "yetone/avante.nvim",
    branch = "main",
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "hrsh7th/nvim-cmp",
      "nvim-tree/nvim-web-devicons",
      "HakonHarnes/img-clip.nvim",
      "zbirenbaum/copilot.lua",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      provider = "openai",
      openai = {
        model = "gpt-4o",
        temperature = 0,
      },
    },
    config = function()
      require("avante").setup()
    end,
  },
}
