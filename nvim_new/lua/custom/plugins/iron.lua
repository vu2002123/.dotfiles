return {
  'Vigemus/iron.nvim',
  main = 'iron.core',
  opts = function()
    local view = require 'iron.view'

    return {
      config = {
        -- This forces the REPL to open on the right (Vertical Split)
        -- '50' is the width of the pane. Change it to whatever you like.
        repl_open_cmd = view.split.vertical.botright(70),

        -- Define how python should run
        repl_definition = {
          python = {
            -- "python" will automatically use your currently active Conda env
            -- Change to "ipython" if you have it installed for a better REPL experience
            command = { 'ipython' },
            format = require('iron.fts.common').bracketed_paste_python,
          },
        },
      },

      -- Keybindings
      -- <leader>rs = Send visual selection
      -- <leader>rr = Restart/Open REPL
      keymaps = {
        toggle_repl = '<leader>rr',
        restart_repl = '<leader>rR',
        send_motion = '<leader>r',
        visual_send = '<leader>rv',
        send_file = '<leader>rf',
        send_line = '<leader>rl',
        send_paragraph = '<leader>rp',
        send_file = '<leader>rf',
        send_line = '<leader>rl',
        send_until_cursor = '<leader>rc',
        clear = '<leader>cl',
      },

      -- If you want the REPL to close when you quit nvim
      should_map_plug = false,
      scratch_repl = true,
    }
  end,
}
