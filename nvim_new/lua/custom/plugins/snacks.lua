return {
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    opts = {
      -- Enable the picker module
      picker = { enabled = true },
      -- helper to configure the explorer to your liking (optional)
      explorer = { enabled = false },
    },
    keys = {
      -- Top Pickers & Explorer
      {
        '<leader><leader>',
        function()
          Snacks.picker.buffers()
        end,
        desc = '[ ] Find existing buffers',
      },
      {
        '<leader>sf',
        function()
          Snacks.picker.files()
        end,
        desc = '[S]earch [F]iles',
      },
      {
        '<leader>sg',
        function()
          Snacks.picker.grep()
        end,
        desc = '[S]earch by [G]rep',
      },
      {
        '<leader>s.',
        function()
          Snacks.picker.recent()
        end,
        desc = "[S]earch Recent Files ('.')",
      },

      -- Git (optional, added for parity with standard Telescope usage)
      {
        '<leader>gl',
        function()
          Snacks.picker.git_log()
        end,
        desc = '[G]it [L]og',
      },
      {
        '<leader>gs',
        function()
          Snacks.picker.git_status()
        end,
        desc = '[G]it [S]tatus',
      },

      -- Grep
      {
        '<leader>sw',
        function()
          Snacks.picker.grep_word()
        end,
        desc = '[S]earch current [W]ord',
      },
      {
        '<leader>s/',
        function()
          Snacks.picker.grep { buffers = true }
        end,
        desc = '[S]earch [/] in Open Files',
      },

      -- Search
      {
        '<leader>s"',
        function()
          Snacks.picker.registers()
        end,
        desc = '[S]earch Registers',
      },
      {
        '<leader>sd',
        function()
          Snacks.picker.diagnostics()
        end,
        desc = '[S]earch [D]iagnostics',
      },
      {
        '<leader>sr',
        function()
          Snacks.picker.resume()
        end,
        desc = '[S]earch [R]esume',
      },
      {
        '<leader>sh',
        function()
          Snacks.picker.help()
        end,
        desc = '[S]earch [H]elp',
      },
      {
        '<leader>sk',
        function()
          Snacks.picker.keymaps()
        end,
        desc = '[S]earch [K]eymaps',
      },
      {
        '<leader>ss',
        function()
          Snacks.picker.pickers()
        end,
        desc = '[S]earch [S]elect Picker',
      },

      -- Search current buffer (Equivalent to current_buffer_fuzzy_find)
      {
        '<leader>/',
        function()
          Snacks.picker.lines()
        end,
        desc = '[/] Fuzzily search in current buffer',
      },

      -- Config Search
      {
        '<leader>sn',
        function()
          Snacks.picker.files { cwd = vim.fn.stdpath 'config' }
        end,
        desc = '[S]earch [N]eovim files',
      },
    },
  },
}
