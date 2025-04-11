vim.g.mapleader = " "
local keymap = vim.keymap.set

keymap("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
keymap("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find Files" })
keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Live Grep" })
