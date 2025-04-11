require("which-key").register({
    ["<leader>"] = {
        e = { ":NvimTreeToggle<CR>", "Alternar Explorer" },
        f = {
            name = "Buscar", -- nome do grupo
            f = { "<cmd>Telescope find_files<CR>", "Arquivos" },
            g = { "<cmd>Telescope live_grep<CR>", "Grep texto" },
        },
        t = {
            name = "Terminal",
            t = { "<cmd>ToggleTerm<CR>", "Abrir terminal" },
        },
    }
})
