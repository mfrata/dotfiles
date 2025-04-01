local options = {
  showcmd = true,                          -- Show me what I'm typing
  number = true,                           -- Show line numbers
  relativenumber = true,                   -- Show relative too
  swapfile = false,                        -- Don't create annoying backup files
  incsearch = true,                        -- Shows the match while typing
  hlsearch = true,                         -- Highlight found searches
  ignorecase = true,                       -- Search case insensitive...
  smartcase = true,                        -- ... but not if begins with upper case
  tabstop = 4,                             -- tabs = X columns
  shiftwidth = 4,                          -- X columns identation keys
  expandtab = true,                        -- tabs = spaces (youtube.com/watch?v=SsoOG6ZeyUI)
  laststatus = 2,                          -- Used by lightline
  shell = "zsh",                           -- Oh my sweet shell
  diffopt = "vertical",                    -- Fugitive Gdiff vertical split
  inccommand = "split",                    -- Open buffer on search showing all results
  termguicolors = true,                    -- set term gui colors (most terminals support this)
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0                         -- so that `` is visible in markdown files
}

vim.opt_global.shortmess:remove("F")

for k, v in pairs(options) do
  vim.opt[k] = v
end
