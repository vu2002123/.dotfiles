return {
  'nvim-treesitter/nvim-treesitter-context',
  event = 'BufReadPre',
  opts = {
    enable = true, -- Enable this plugin (Can be disabled toggle with :TSContextToggle)
    max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
    min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
    line_numbers = true,
    multiline_threshold = 20, -- Maximum number of lines to show for a single context
    trim_scope = 'outer', -- Which context lines to discard if exceeding max_lines choices: 'inner', 'outer'
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil, -- Separator between context and content. e.g. "-"
    zindex = 20, -- The Z-index of the context window
  },
}
