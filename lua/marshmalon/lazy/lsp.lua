return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },
  config = function()
    -- === Requerimentos iniciais ===
    local lspconfig = require("lspconfig")
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local cmp_lsp = require("cmp_nvim_lsp")

    local capabilities = vim.tbl_deep_extend(
      "force",
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities()
    )

    -- === Mason + Fidget ===
    mason.setup()
    require("fidget").setup({})

    -- === LSP Setup ===
    local servers = { "ts_ls", "lua_ls", "ruff" }

    local function default_handler(server_name)
      lspconfig[server_name].setup({ capabilities = capabilities })
    end

    mason_lspconfig.setup({
      ensure_installed = servers,
      handlers = {
        default_handler,
        lua_ls = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                runtime = { version = 'LuaJIT' },
                diagnostics = { globals = { 'vim', 'love' } },
                workspace = { library = { vim.env.VIMRUNTIME } },
                telemetry = { enable = false },
              }
            }
          })
        end
      }
    })

    -- === nvim-cmp Setup ===
    require("luasnip.loaders.from_vscode").lazy_load() -- friendly-snippets recomendado

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        -- Adicione mais mapeamentos se quiser (ex: <C-n>, <C-p>, <Tab>)
      }),
      sources = {
        { name = 'path' },
        { name = 'nvim_lsp' },
        { name = 'luasnip', keyword_length = 2 },
        { name = 'buffer',  keyword_length = 3 },
      },
    })
  end,
}
