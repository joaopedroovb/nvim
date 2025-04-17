local which_key = require "which-key"
local builtin = require('telescope.builtin')

-- Autocomando para configurar os atalhos LSP quando o LSP for anexado ao buffer
vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', { clear = true }),
  callback = function(event)
    local opts = { buffer = event.buf }

    local mappings = {
      g = {
        d = { vim.lsp.buf.definition, "Ir para definição" },
        l = { vim.diagnostic.open_float, "Abrir diagnóstico flutuante" },
      },
      K = { vim.lsp.buf.hover, "Mostrar informações" },
      ["<leader>"] = {
        l = {
          name = "LSP",
          a = { vim.lsp.buf.code_action, "Ação de código" },
          r = { vim.lsp.buf.references, "Referências" },
          n = { vim.lsp.buf.rename, "Renomear" },
          w = { vim.lsp.buf.workspace_symbol, "Símbolos do workspace" },
          d = { vim.diagnostic.open_float, "Abrir diagnóstico flutuante" },
        },
      },
      ["[d"] = { vim.diagnostic.goto_next, "Próximo diagnóstico" },
      ["]d"] = { vim.diagnostic.goto_prev, "Diagnóstico anterior" },
    }

    which_key.register(mappings, opts)

    -- Formatar automaticamente antes de salvar
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = event.buf,
      callback = function()
        vim.lsp.buf.format { async = false, id = event.data.client_id }
      end
    })
  end,
})

-- Mapeamentos gerais (fora do LSP)
local non_lsp_mappings = {
  ["<leader>"] = {
    e = { vim.cmd.Ex, "Abrir explorador de arquivos" },
    p = { "\"_dP", "Colar sem sobrescrever" },
    ["/"] = { "<Plug>(comment_toggle_linewise_current)", "Comentar/descomentar linha" },
    s = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Buscar e substituir palavra" },
  },
  J = { "mzJ`z", "Unir linhas mantendo o cursor" },
  ["<C-d>"] = { "<C-d>zz", "Descer meia página centralizando" },
  ["<C-u>"] = { "<C-u>zz", "Subir meia página centralizando" },
  n = { "nzzzv", "Próximo resultado e centralizar" },
  N = { "Nzzzv", "Resultado anterior e centralizar" },
  Q = { "<nop>", "Desativar modo Ex" },
}

which_key.register(non_lsp_mappings)

-- Comandos do Telescope
local telescope_mappings = {
  f = {
    name = "Buscar",
    f = { builtin.find_files, "Buscar arquivos" },
    g = { builtin.git_files, "Buscar arquivos Git" },
    l = { builtin.live_grep, "Grep ao vivo" },
  },
}

which_key.register(telescope_mappings, { prefix = "<leader>" })

-- Atalho separado para listar buffers abertos
which_key.register({
  [";"] = { builtin.buffers, "Listar buffers" },
})

-- Mapeamentos para modo visual
local visual_mappings = {
  J = { ":m '>+1<CR>gv=gv", "Mover seleção para baixo" },
  K = { ":m '<-2<CR>gv=gv", "Mover seleção para cima" },
  ["<leader>"] = {
    ["/"] = { "<Plug>(comment_toggle_linewise_visual)", "Comentar/descomentar visual" },
  },
}

which_key.register(visual_mappings, { mode = "v" })

-- Impedir que colar no modo visual sobrescreva o conteúdo copiado
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Atalho para formatar manualmente
vim.keymap.set("n", "<leader>f", function()
  vim.lsp.buf.format()
end, { desc = "Formatar código" })

-- Inserção: seta para a direita funciona normalmente
vim.keymap.set('i', '<Right>', '<Right>', { noremap = true })

vim.keymap.set("n", "<leader>b", "<cmd>NvimTreeToggle<CR>", { desc = "Alternar NvimTree" })
