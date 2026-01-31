return {
  'brianhuster/live-preview.nvim',
  dependencies = {
    -- You can choose one of the following pickers
    'folke/snacks.nvim',
  },
  require('livepreview.config').set {
    port = 5499,
  },
}
