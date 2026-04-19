return {
  -- LSPサーバーの自動インストール
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    opts = { ui = { border = "rounded" } },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = { "lua_ls", "pyright", "ts_ls", "rust_analyzer" },
      automatic_enable = true,  -- Neovim 0.11+: vim.lsp.enable() を自動呼び出し
    },
  },

  -- LSP設定 (Neovim 0.11+ の新API)
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      -- 全サーバーに補完のcapabilitiesを設定
      vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
      })

      -- サーバー固有の設定
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })

      vim.lsp.config("rust_analyzer", {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = true,
            check = { command = "clippy" },
          },
        },
      })

      -- LSP接続時のキーマップ
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(keys, func, desc)
            vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
          end
          map("gd",         vim.lsp.buf.definition,                              "Go to definition")
          map("gr",         vim.lsp.buf.references,                              "References")
          map("K",          vim.lsp.buf.hover,                                   "Hover docs")
          map("<leader>ca", vim.lsp.buf.code_action,                             "Code action")
          map("<leader>rn", vim.lsp.buf.rename,                                  "Rename")
          map("<leader>f",  function() vim.lsp.buf.format({ async = true }) end, "Format")
          map("[d",         vim.diagnostic.goto_prev,                            "Prev diagnostic")
          map("]d",         vim.diagnostic.goto_next,                            "Next diagnostic")
        end,
      })
    end,
  },

  -- 補完エンジン
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"]     = cmp.mapping.select_next_item(),
          ["<C-p>"]     = cmp.mapping.select_prev_item(),
          ["<C-d>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"]     = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        window = {
          completion    = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      })
    end,
  },
}
