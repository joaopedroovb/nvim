local lspconfig = require("lspconfig")

-- ts_ls (TypeScript Language Server)
lspconfig.ts_ls.setup({
  on_attach = function(client, bufnr)
    -- Formatar ao salvar
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

-- Lua LSP
lspconfig.lua_ls.setup({})

-- Autocompletion (nvim-cmp)
local cmp = require("cmp")
cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  }),
  sources = {
    { name = "nvim_lsp" },
  },
})

-- Prettier com null-ls
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.prettier,
  },
})
