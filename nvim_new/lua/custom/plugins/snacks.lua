return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- 1. Image Module Configuration (from docs/image.md)
    image = {
      enabled = true,
      doc = {
        -- Render images inside markdown/norg files?
        inline = false, -- set to true if you want inline images in text
        -- Render images in the floating preview window?
        float = true,
      },
    },

    -- 2. Picker Configuration (File Manager)
    picker = {
      enabled = true,
    },
  },

  -- 3. Keybinds
  keys = {
    {
      '<leader>fm',
      function()
        Snacks.picker.files()
      end,
      desc = 'File Manager',
    },
  },
}
