return {
  -- git差分を行番号横に表示
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add          = { text = "▎" },
        change       = { text = "▎" },
        delete       = { text = "" },
        topdelete    = { text = "" },
        changedelete = { text = "▎" },
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end
        map("]h", gs.next_hunk,                    "Next hunk")
        map("[h", gs.prev_hunk,                    "Prev hunk")
        map("<leader>hs", gs.stage_hunk,           "Stage hunk")
        map("<leader>hr", gs.reset_hunk,           "Reset hunk")
        map("<leader>hp", gs.preview_hunk,         "Preview hunk")
        map("<leader>hb", gs.blame_line,           "Blame line")
        map("<leader>hd", gs.diffthis,             "Diff this")
      end,
    },
  },

  -- キーマップヒント表示
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
      icons = { mappings = false },
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>f", group = "find / format" },
        { "<leader>h", group = "git hunk" },
        { "<leader>c", group = "code" },
        { "<leader>r", group = "rename" },
      },
    },
  },
}
