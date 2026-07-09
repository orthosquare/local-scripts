vim.pack.add({ {
  src = "https://github.com/ibhagwan/fzf-lua",
} })

require("fzf-lua").setup()

vim.keymap.set("n", "<leader>ff", function()
  require("fzf-lua").files()
end, { desc = "[F]ind [F]ile using fzf" })

vim.keymap.set("n", "<leader>fg", function()
  require("fzf-lua").live_grep()
end, { desc = "[F]ind file by contents using rip[G]rep in project directory" })

vim.keymap.set("n", "<leader>fr", function()
  require("fzf-lua").resume()
end, { desc = "[F]ind by [R]esuming previous fzf session" })

vim.keymap.set("n", "<leader>fc", function()
  require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[F]ind files in the neovim [C]onfig directory" })

vim.keymap.set("n", "<leader><leader>", function()
  require("fzf-lua").buffers()
end, { desc = "[F]ind from the current open buffers" })

vim.keymap.set("n", "<leader>fh", function()
  require("fzf-lua").helptags()
end, { desc = "[F]ind nvim [H]elp tags" })

vim.keymap.set("n", "<leader>fk", function()
  require("fzf-lua").keymaps()
end, { desc = "[F]ind [K]eymaps for nvim" })
