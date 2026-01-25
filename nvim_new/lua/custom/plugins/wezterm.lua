return {
  'willothy/wezterm.nvim',
  config = function()
    local wezterm = require 'wezterm'

    vim.keymap.set('n', '<leader>tt', function()
      -- 1. Check current background state
      local is_dark = vim.o.background == 'dark'

      -- 2. Define targets
      -- WezTerm uses "Catppuccin Latte" for its built-in light theme
      local target_wez = is_dark and 'Catppuccin Latte' or 'Gruvbox Material (Gogh)'
      local target_bg = is_dark and 'light' or 'dark'

      -- 3. Sync WezTerm
      wezterm.set_user_var('color_scheme', target_wez)

      -- 4. Sync Neovim internally
      vim.o.background = target_bg

      if target_bg == 'light' then
        -- Set flavor for Catppuccin before applying
        require('catppuccin').setup { flavour = 'latte' }
        vim.cmd.colorscheme 'catppuccin'
      else
        -- Logic for Gruvbox Material Dark
        vim.g.gruvbox_material_background = 'medium'
        vim.cmd.colorscheme 'gruvbox-material'
      end

      -- 5. Persistence: Save to your cache file
      local cache_path = vim.fn.stdpath 'config' .. '/lua/custom/saved_theme.lua'
      local f = io.open(cache_path, 'w')
      if f then
        f:write("return '" .. target_bg .. "'")
        f:close()
      end

      print('Theme toggled to ' .. (target_bg == 'light' and 'Catppuccin Latte' or 'Gruvbox Dark'))
    end, { desc = 'Toggle Theme (Catppuccin/Gruvbox)' })
  end,
}
