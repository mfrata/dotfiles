-- Remove trailing whitespace
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  command = [[%s/\s\+$//e]],
})

-- Quit if only NERDTree is open
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    if vim.fn.winnr("$") == 1 and vim.b.NERDTree and vim.b.NERDTree.isTabTree() then
      vim.cmd("q")
    end
  end,
})

-- Metals LSP attach
vim.api.nvim_create_augroup("lsp", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "java", "scala", "sbt" },
  group = "lsp",
  callback = function()
    require("metals").initialize_or_attach({})
  end,
})

-- Avante highlights
vim.api.nvim_create_autocmd("FileType", {
  pattern = "Avante",
  callback = function()
    vim.api.nvim_set_hl(0, "AvanteSidebarNormal", { link = "Normal" })
    vim.api.nvim_set_hl(0, "AvanteSidebarWinSeparator", { link = "WinSeparator" })
    local normal_bg = string.format("#%06x", vim.api.nvim_get_hl(0, { name = "Normal" }).bg or 0)
    vim.api.nvim_set_hl(0, "AvanteSidebarWinHorizontalSeparator", { fg = normal_bg })
  end,
})

-- Lightline filename function
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

vim.g.lightline = {
  colorscheme = "nord",
  component_function = {
    filename = "LightlineFilename",
  }
}

vim.g.highlightedyank_highlight_duration = 300
