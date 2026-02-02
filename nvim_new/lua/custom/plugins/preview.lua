return {
  'brianhuster/live-preview.nvim',
  dependencies = {
    'folke/snacks.nvim',
  },
  config = function()
    require('livepreview.config').set {
      port = 5499,
    }
  end,
}
