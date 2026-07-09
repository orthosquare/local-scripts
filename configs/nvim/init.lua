-- Basic setup --
vim.o.number = true
vim.o.wrap = false
vim.o.cursorline = true

-- Indentation --
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.smartindent = true
vim.o.autoindent = true

-- File handling --
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.undofile = true
vim.o.undodir = vim.fn.expand("~/.vim/undodir")
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.ttimeoutlen = 0
vim.o.autoread = true
vim.o.autowrite = false

-- Create undo directory if it does not already exist
local undodir = vim.fn.expand("~/.vim/undodir")
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p")
end

-- QoL changes --
vim.o.hidden = true
vim.o.clipboard = "unnamedplus"
vim.o.backspace = "indent,eol,start"
vim.o.signcolumn = "yes"

-- Display changes --
vim.opt.showbreak = "↪"
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣", precedes = "←", extends = "→", eol = "↲" }
vim.opt.list = true

-- nvim keymaps --
local map = vim.keymap.set
vim.g.mapleader = ","
vim.g.maplocalleader = ","

map("n", "<leader>o", ":update<CR>:source<CR>")

map("n", "n", "nzzzv", { desc = "Next search result (centered)" })
map("n", "N", "Nzzzv", { desc = "Previous search result (centered)" })

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { desc = "Previous buffer" })

-- Splitting and Resizing
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Split window vertically" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Split window horizontally" })
vim.keymap.set("n", "<leader><C-Up>", ":resize +2<CR>", { desc = "Increase window height" })
vim.keymap.set("n", "<leader><C-Down>", ":resize -2<CR>", { desc = "Decrease window height" })
vim.keymap.set("n", "<leader><C-Left>", ":vertical resize -2<CR>", { desc = "Decrease window width" })
vim.keymap.set("n", "<leader><C-Right>", ":vertical resize +2<CR>", { desc = "Increase window width" })

-- Better window navigation
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the right window" })

-- Move lines up/down
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent selection left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent selection right" })

-- Better J behaviour
vim.keymap.set("n", "J", "mzj`z", { desc = "Join lines and keep cursor position" })

-- Basic auto commands
local augroup = vim.api.nvim_create_augroup("UserConfig", {})

-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup,
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Return to last edit position when opening files
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup,
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  group = augroup,
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

require("plugin/fzf-lua")
require("plugin/kanagawa")
require("plugin/mason")
require("plugin/nvim-lspconfig")
require("plugin/oil")
require("plugin/lualine")
require("plugin/mini-icons")
require("plugin/which-key")
