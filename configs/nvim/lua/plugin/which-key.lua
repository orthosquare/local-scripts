vim.pack.add({
  "https://github.com/folke/which-key.nvim",
})

require("which-key").setup()

vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "buffer local keymaps (which-key)" })
