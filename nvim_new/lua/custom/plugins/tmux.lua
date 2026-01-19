return {
  'aserowy/tmux.nvim',
  config = function()
    local tmux = require 'tmux'

    tmux.setup {
      copy_sync = {
        enable = true,
        redirect_to_clipboard = true, -- SSH copy enabled
      },
      navigation = {
        enable_default_keybindings = true,
        cycle_navigation = true,
      },
      resize = {
        enable_default_keybindings = true,
        resize_step_x = 5,
        resize_step_y = 2,
      },
    }
  end,
}
