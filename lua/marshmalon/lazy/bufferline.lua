return {
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'ramojus/mellifluous.nvim',
  },
  config = function()
    vim.cmd.colorscheme("mellifluous")
    vim.opt.termguicolors = true
    require('bufferline').setup {}
  end
}
