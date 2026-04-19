-- リーダーキーは lazy.nvim より前に設定する必要あり
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local map = vim.keymap.set

-- 基本操作
map("i", "jk", "<Esc>", { desc = "Escape insert mode" })
map("n", "<leader>w", "<cmd>w<CR>", { desc = "Save" })
map("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit" })


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
-- コマンドモード: <S-N> → 記号（! " # $ % & ' ( ) ~）
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
-- インサートモード: <S-N> → 記号
map("i", "<S-1>", "!")
map("i", "<S-2>", '"')
map("i", "<S-3>", "#")
map("i", "<S-4>", "$")
map("i", "<S-5>", "%")
map("i", "<S-6>", "&")
map("i", "<S-7>", "'")
map("i", "<S-8>", "(")
map("i", "<S-9>", ")")
map("i", "<S-0>", "~")
-- ノーマルモード: <S-N> → 数字（カウント操作を可能にする）
map("n", "<S-1>", "1")
map("n", "<S-2>", "2")
map("n", "<S-3>", "3")
map("n", "<S-4>", "4")
map("n", "<S-5>", "5")
map("n", "<S-6>", "6")
map("n", "<S-7>", "7")
map("n", "<S-8>", "8")
map("n", "<S-9>", "9")
map("n", "<S-0>", "0")
