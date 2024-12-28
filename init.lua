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
  
  -- Ativar o mouse
  vim.o.mouse = "a"
  