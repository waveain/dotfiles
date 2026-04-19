return {
  -- ステータスライン
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = {
        theme = "tokyonight",
        globalstatus = true,
      },
    },
  },

  -- ファイルツリー
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<C-n>",     "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
      { "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Toggle file tree" },
    },
    opts = {
      window = { width = 30 },
      filesystem = {
        filtered_items = {
          hide_dotfiles = false,
        },
      },
    },
  },
}
