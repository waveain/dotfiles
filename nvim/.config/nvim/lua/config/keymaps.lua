-- リーダーキーは lazy.nvim より前に設定する必要あり
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

-- 基本操作
map("i", "jk", "<Esc>", { desc = "Escape insert mode" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })

-- ウィンドウ移動
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- バッファ
map("n", "<leader>bn", "<cmd>bnext<CR>",   { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprev<CR>",   { desc = "Prev buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete buffer" })

-- 検索ハイライトをクリア
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- 行移動（折り返し対応）
map("n", "j", "gj")
map("n", "k", "gk")

-- WSL2でShift+数字キーが正しく送られない問題の回避
map("c", "<S-1>", "!", { desc = "Fix Shift+number in command mode on WSL2" })
map("c", "<S-2>", '"')
map("c", "<S-3>", "#")
map("c", "<S-4>", "$")
map("c", "<S-5>", "%")
map("c", "<S-6>", "&")
map("c", "<S-7>", "'")
map("c", "<S-8>", "(")
map("c", "<S-9>", ")")
map("c", "<S-0>", "~")
