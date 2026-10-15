vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim"}
})

require("mason").setup({ path = "append" })
require("mason-lspconfig").setup()
