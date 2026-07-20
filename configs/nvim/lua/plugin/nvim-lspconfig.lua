vim.pack.add({
  { src = "https://github.com/neovim/nvim-lspconfig" },
})

local map = vim.keymap.set

vim.api.nvim_create_autocmd('LspAttach', {

  group = vim.api.nvim_create_augroup('my.lsp', {}),

  callback = function(ev)

    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))
    -- Enable auto-completion. Note: Use CTRL-Y to select an item. |complete_CTRL-Y|
    if client:supports_method('textDocument/completion') then
      -- Optional: trigger autocompletion on EVERY keypress. May be slow!
      --
      -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
      -- client.server_capabilities.completionProvider.triggerCharacters = chars

      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = false})

    end
  end,

})

map('i', '<c-space>', function () vim.lsp.completion.get() end)

map('n', '<leader>cf', vim.lsp.buf.format, { desc = "LSP: [C]ode [F]ormat" })
map('n', '<leader>rn', vim.lsp.buf.rename, { desc = "LSP: [R]e[n]ame" })
map('n', '<leader>ca', vim.lsp.buf.code_action, { desc = "LSP: [C]ode [A]ction" })
map('n', '<leader>sf', function() vim.lsp.buf.hover({ border = "rounded" }) end, { desc = "LSP: [S]how symbol [f]loat" })
map('n', '<leader>rf', require("fzf-lua").lsp_references, { desc = "LSP: Find [r]e[f]erences" })
map('n', '<leader>im', require("fzf-lua").lsp_implementations, { desc = "LSP: Find [I][m]plementations" })
map('n', '<leader>df', require("fzf-lua").lsp_definitions, { desc = "LSP: Find [D]e[f]initions" })
map('n', '<leader>rf', require("fzf-lua").lsp_references, { desc = "LSP: Find [r]e[f]erences" })

map("n", "gO", require("fzf-lua").lsp_document_symbols, { desc = "LSP: Open Document Symbols" })
map("n", "gW", require("fzf-lua").lsp_live_workspace_symbols, { desc = "LSP: Open Workspace Symbols" })
map("n", "<leader>td", require("fzf-lua").lsp_typedefs, { desc = "LSP: Goto [T]ype [D]efinition" })

vim.diagnostic.config({
  severity_sort = true,
  float = { border = "rounded", source = "always" },
  underline = { severity = vim.diagnostic.severity.ERROR },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "󰅚 ",
      [vim.diagnostic.severity.WARN] = "󰀪 ",
      [vim.diagnostic.severity.INFO] = "󰋽 ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  } or {},
  virtual_text = {
    source = "if_many",
    spacing = 2,
    format = function(diagnostic)
      local diagnostic_message = {
        [vim.diagnostic.severity.ERROR] = diagnostic.message,
        [vim.diagnostic.severity.WARN] = diagnostic.message,
        [vim.diagnostic.severity.INFO] = diagnostic.message,
        [vim.diagnostic.severity.HINT] = diagnostic.message,
      }
      return diagnostic_message[diagnostic.severity]
    end,
  },
})

vim.keymap.set("n", "gl", function()
  vim.diagnostic.open_float()
end, { desc = "Open diagnostics in float" })

vim.cmd [[set completeopt+=menuone,noselect,popup]]

vim.lsp.config['custom_tinymist'] = {

  -- Command and arguments to start the server.
  cmd = { 'tinymist' },

  -- Filetypes to automatically attach to.
  filetypes = { 'typst' },

  -- Sets the workspace "root" to the directory where any of these files is found.
  -- Files sharing a root will reuse the LSP client/connection.
  -- Nested lists indicate equal priority, see |vim.lsp.Config|.
  root_markers = { '.git' },

  settings = {
    formatterIndentSize = 2,
    formatterMode = "typstyle",
    formatterPrintWidth = 80,
    formatterProseWrap = true,
    formatterIndentSize = 2,
  }

}

-- Register language servers here.
vim.lsp.enable({ "lua_ls", "custom_tinymist", "rust_analyzer" })

vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())

map('i', '<c-space>', function()

  vim.lsp.completion.get()

end)
