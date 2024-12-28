-- Certifique-se de que o Packer está instalado
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Iniciar o Packer
require("packer").startup(function(use)
  use "wbthomason/packer.nvim" -- Gerenciador de plugins
  use "nvim-tree/nvim-tree.lua" -- Sidebar
  use "nvim-lualine/lualine.nvim" -- Statusline
  use "nvim-treesitter/nvim-treesitter" -- Melhorar a sintaxe
  use "nvim-telescope/telescope.nvim" -- Busca avançada

  -- Adicionando o tema Catppuccin
  use { "catppuccin/nvim", as = "catppuccin" }

  -- Adicionando o ToggleTerm
  use "akinsho/toggleterm.nvim"

  if packer_bootstrap then
    require("packer").sync()
  end
end)

-- Configuração básica para nvim-tree
require("nvim-tree").setup({
  view = {
    width = 30,
    side = "left",
  },
})

-- Atalho para abrir a sidebar
vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
-- Configuração dos Keymaps Personalizados
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Abrir o terminal com <Ctrl-t>
keymap("n", "<C-t>", ":ToggleTerm<CR>", opts)

-- Abrir o nvim-tree com <Ctrl-n>
keymap("n", "<C-n>", ":NvimTreeToggle<CR>", opts)

-- Criar um novo arquivo com <leader>n
keymap("n", "<leader>n", ":e <C-R>=expand('%:p:h') . '/' <CR>", opts)

-- Mostrar o diretório atual com <leader>d
keymap("n", "<leader>d", ":echo expand('%:p:h')<CR>", opts)

-- Criar uma nova pasta com <leader>p
keymap("n", "<leader>p", function()
  local folder_name = vim.fn.input("Nome da Pasta: ", "", "file")
  local current_dir = vim.fn.expand("%:p:h")
  local full_path = current_dir .. "/" .. folder_name
  if folder_name ~= "" then
    vim.fn.mkdir(full_path, "p")
    print("Pasta criada: " .. full_path)
  else
    print("Nenhuma pasta criada.")
  end
end, opts)

-- Ativar o mouse
vim.o.mouse = "a"

-- Configuração do tema Catppuccin
require("catppuccin").setup({
  flavour = "mocha", -- Estilo do tema: latte, frappe, macchiato, mocha
  transparent_background = false, -- Fundo transparente
  term_colors = true, -- Aplicar cores ao terminal embutido
  integrations = {
    nvimtree = true, -- Integração com nvim-tree
    treesitter = true, -- Suporte ao Treesitter
    lualine = true, -- Integração com lualine
    telescope = true, -- Integração com Telescope
  },
})

-- Ative o tema
vim.cmd([[colorscheme catppuccin]])

-- Configuração do ToggleTerm
require("toggleterm").setup({
  size = 20, -- Altura do terminal para terminais horizontais
  open_mapping = [[<C-\>]], -- Atalho para abrir/fechar o terminal
  direction = "horizontal", -- Direção do terminal: horizontal, vertical, tab, float
  float_opts = {
    border = "curved", -- Borda do terminal flutuante
  },
})

-- Exemplo de terminal personalizado (opcional)
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })

function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>g", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", { noremap = true, silent = true })
