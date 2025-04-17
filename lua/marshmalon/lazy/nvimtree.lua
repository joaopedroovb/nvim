return {
  "nvim-tree/nvim-tree.lua",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup({
      view = {
        width = 30,
        side = "left",
        relativenumber = true,
        preserve_window_proportions = true,

      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        root_folder_label = false,
        icons = {
          show = {
            folder = true,
            file = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
      },
      git = {
        enable = true,
        ignore = false,
      },
      update_focused_file = {
        enable = true,
        update_cwd = true,
        update_root = true,
      },
      actions = {
        open_file = {
          resize_window = true,
          quit_on_open = false,
        },
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      diagnostics = {
        enable = true,
        show_on_dirs = true,
      },
      filesystem_watchers = {
        enable = true,
      },
    })

    -- 🔥 Aqui vem o autocomando atualizado
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        local is_directory = vim.fn.isdirectory(data.file) == 1

        -- Abrir automaticamente se for um diretório
        if is_directory then
          vim.cmd.cd(data.file)
          require("nvim-tree.api").tree.open()
          return
        end

        -- Abrir automaticamente se não houver argumentos
        if vim.fn.argc() == 0 then
          require("nvim-tree.api").tree.open()
        end
      end,
    })
  end,
}
