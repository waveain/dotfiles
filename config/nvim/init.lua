-- 基本設定
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.updatetime = 300
vim.opt.signcolumn = "yes"

-- lazy.nvim のセットアップ
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- プラグイン
require("lazy").setup({
  {"nvim-lua/plenary.nvim"},
  {"nvim-telescope/telescope.nvim"},
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"},

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {"nvim-tree/nvim-web-devicons"},
    config = function()
      require("nvim-tree").setup({})
    end
  },

  {"neovim/nvim-lspconfig"},

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio"
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"]  = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"]  = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"]      = function() dapui.close() end
    end
  },

  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "rouge8/neotest-rust",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim"
    },
    config = function()
      local neotest = require("neotest")
      neotest.setup({ adapters = { require("neotest-rust") } })

      vim.keymap.set("n", "<leader>tt", function() neotest.run.run() end)
      vim.keymap.set("n", "<leader>tf", function() neotest.run.run(vim.fn.expand("%")) end)
      vim.keymap.set("n", "<leader>ts", function() neotest.run.stop() end)
      vim.keymap.set("n", "<leader>to", function() neotest.output.open({ enter = true }) end)
      vim.keymap.set("n", "<leader>ta", function() neotest.run.attach() end)
    end
  },

  {
    "saecki/crates.nvim",
    event = {"BufRead Cargo.toml"},
    dependencies = {"nvim-lua/plenary.nvim"},
    config = function()
      require("crates").setup()
    end
  }
})

-- Rust Analyzer LSP
vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      cargo = { allFeatures = true },
      checkOnSave = true,
      check = { command = "clippy" }
    }
  }
})
vim.lsp.enable("rust_analyzer")

-- キーマッピング
vim.keymap.set("n", "<C-n>",      "<cmd>NvimTreeToggle<CR>")
vim.keymap.set("n", "<C-p>",      "<cmd>Telescope find_files<CR>")
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>")
