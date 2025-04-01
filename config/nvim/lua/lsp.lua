local M = {}

-- Keymaps for LSP attached buffers
local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  local keymap = vim.keymap.set

  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("n", "gi", vim.lsp.buf.implementation, opts)
  keymap("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)

  keymap("n", "[d", vim.diagnostic.goto_prev, opts)
  keymap("n", "]d", vim.diagnostic.goto_next, opts)
  keymap("n", "gl", vim.diagnostic.open_float, opts)
  keymap("n", "<leader>q", vim.diagnostic.setloclist, opts)

  keymap("n", "<leader>rn", vim.lsp.buf.rename, opts)
  keymap("n", "<leader>ca", vim.lsp.buf.code_action, opts)
  keymap("n", "<leader>f", function()
    vim.lsp.buf.format { async = true }
  end, opts)

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function()
    vim.lsp.buf.format { async = true }
  end, { desc = "Format current buffer with LSP" })
end

-- Attach and configure language servers
M.setup = function()
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities()

  local servers = {
    "lua_ls",
    "pyright",
    "tsserver",
    "jsonls",
    -- add more here
  }

  for _, server in ipairs(servers) do
    lspconfig[server].setup({
      on_attach = function(_, bufnr)
        lsp_keymaps(bufnr)
      end,
      capabilities = capabilities,
    })
  end
end

return M
