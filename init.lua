-- Bootstrap do Lazy.nvim (TEM QUE VIR PRIMEIRO)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Carrega configurações básicas
require("options")
require("keymaps")

-- Carrega plugins a partir do arquivo plugins.lua
require("lazy").setup("plugins")

-- Configura LSP e autocompletion
require("lsp")

-- Atalhos com popup
require("whichkey")
