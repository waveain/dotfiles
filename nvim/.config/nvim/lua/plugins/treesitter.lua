return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "bash", "lua", "python", "javascript", "typescript",
          "json", "yaml", "toml", "markdown", "markdown_inline",
          "html", "css", "go", "rust",
        },
      })
    end,
  },
}
