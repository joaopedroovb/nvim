-- Carrega configurações básicas
require("options")
require("keymaps")

-- Bootstrap do Lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- Carrega plugins a partir do arquivo plugins.lua
require("lazy").setup("plugins")

-- Configura LSP e autocompletion
require("lsp")

require("whichkey")
