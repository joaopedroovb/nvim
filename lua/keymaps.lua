vim.g.mapleader = " "
local keymap = vim.keymap.set

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
keymap("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files" })
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep" })

-- Mapeamentos de atalhos personalizados inspirados no VS Code

local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 🖼️ Zoom (requer suporte em GUI como Neovide)
function AdjustFontSize(delta)
    local guifont = vim.opt.guifont:get()
    local name, size = guifont:match("([^:]+):h(%d+)")
    size = tonumber(size or 11) + delta
    vim.opt.guifont = string.format("%s:h%d", name or "FiraCode", size)
end

function ResetFontSize()
    vim.opt.guifont = "FiraCode:h11"
end

map("n", "<C-=>", function() AdjustFontSize(1) end, { desc = "Aumentar zoom" })
map("n", "<C-->", function() AdjustFontSize(-1) end, { desc = "Diminuir zoom" })
map("n", "<C-0>", ResetFontSize, { desc = "Resetar zoom" })

-- 🔍 Busca e comandos
map("n", "<C-p>", ":Telescope find_files<CR>", { desc = "Buscar arquivos" })
map("n", "<C-S-p>", ":Telescope commands<CR>", { desc = "Comandos (Telescope)" })

-- ⚙️ Configurações
map("n", "<C-,>", ":e $MYVIMRC<CR>", { desc = "Abrir config do Neovim" })

-- 🧭 Navegação entre buffers (estilo abas)
map("n", "<C-Tab>", ":BufferLineCycleNext<CR>", opts)
map("n", "<C-S-Tab>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<C-PageUp>", ":BufferLineCyclePrev<CR>", opts)
map("n", "<C-PageDown>", ":BufferLineCycleNext<CR>", opts)

-- 🪟 Janela e visualização
map("n", "<C-b>", ":NvimTreeToggle<CR>", { desc = "Alternar Explorer" })
map("n", "<C-'>", ":ToggleTerm<CR>", { desc = "Alternar terminal" })
map("n", "<C-]>", ":split<CR>", { desc = "Split horizontal" })

-- 🏃‍♂️ Movimentação e seleção
map("n", "<A-Up>", ":m .-2<CR>==", opts)
map("n", "<A-Down>", ":m .+1<CR>==", opts)
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

-- 🔢 Ir para linha
function GoToLine()
    vim.ui.input({ prompt = "Ir para linha: " }, function(input)
        if input then vim.cmd(":" .. input) end
    end)
end

map("n", "<C-g>", ":lua GoToLine()<CR>", { desc = "Ir para linha específica" })

-- 💬 Comentários (requer plugin Comment.nvim)
map("n", "<C-;>", "gcc", { remap = true, desc = "Comentar linha" })
map("v", "<C-;>", "gc", { remap = true, desc = "Comentar seleção" })

-- 🧼 Formatar documento
map("n", "<S-A-F>", function() vim.lsp.buf.format() end, { desc = "Formatar documento" })

-- 📜 Quebra de linha
map("n", "<A-z>", ":set wrap!<CR>", { desc = "Alternar quebra de linha" })

-- Adiciona comando Ctrl+S para salvar
vim.keymap.set("n", "<C-s>", ":w<CR>", { desc = "Salvar arquivo" })
