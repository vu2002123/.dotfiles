return {
  'willothy/wezterm.nvim',
  config = function()
    local wezterm = require 'wezterm'

    function wezterm.set_user_var(name, value)
      local ty = type(value)
      if ty == 'table' then
        value = vim.json.encode(value)
      elseif ty == 'function' or ty == 'thread' then
        error('cannot serialize ' .. ty)
      elseif ty == 'boolean' then
        value = value and 'true' or 'false'
      elseif ty == 'nil' then
        value = ''
      end

      -- 1. Define the Standard Template
      --    \x1b = Escape, \a = Bell
      local template = '\x1b]1337;SetUserVar=%s=%s\a'

      -- 2. [[ THE FIX ]] - Swap Template for Tmux
      if os.getenv 'TMUX' then
        -- We change the envelope to include the Tmux DCS wrapper
        -- \x1bPtmux;  = Start Tmux Pass-through
        -- \x1b\x1b]   = The inner Escape must be doubled
        -- \x1b\\      = End Tmux Pass-through
        template = '\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\a\x1b\\'
      end

      local command = template:format(name, vim.base64.encode(tostring(value)))
      vim.api.nvim_chan_send(vim.v.stderr, command)
    end
    vim.keymap.set('n', '<leader>tt', function()
      -- 1. Check current background state
      local is_dark = vim.o.background == 'dark'

      -- 2. Define targets
      -- WezTerm uses "Catppuccin Latte" for its built-in light theme
      local target_wez = is_dark and 'Catppuccin Latte' or 'Gruvbox Material (Gogh)'
      local target_bg = is_dark and 'light' or 'dark'
      -- local target_weight = is_dark and 'Bold' or 'DemiBold'
      -- require('wezterm').set_user_var("theme_config", {
      -- 	theme = is_dark and "Catppuccin Latte" or "Gruvbox Material (Gogh)",
      -- 	font_weight = is_dark and "Bold" or "DemiBold"
      -- })
      --
      -- 3. Sync WezTerm
      wezterm.set_user_var('color_scheme', target_wez)
      -- wezterm.set_user_var('font_weight', target_weight)

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
