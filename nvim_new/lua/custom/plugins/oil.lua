return {
  {
    'stevearc/oil.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('oil').setup {
        default_file_explorer = true,
        columns = { 'icon' },
        view_options = {
          show_hidden = true,
        },
        -- Configure the floating window appearance
        float = {
          padding = 2,
          max_width = 0,
          max_height = 0,
          border = 'rounded',
          win_options = {
            winblend = 0,
          },
        },
      }

      -- Map - to toggle oil in a floating window
      vim.keymap.set('n', '-', function()
        require('oil').toggle_float()
      end, { desc = 'Open parent directory (Float)' })
    end,
  },
}
