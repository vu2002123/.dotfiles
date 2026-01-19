return {
  'mfussenegger/nvim-dap',
  event = 'VeryLazy',
  dependencies = {
    'rcarriga/nvim-dap-ui', -- UI for debugging
    'nvim-neotest/nvim-nio', -- Required by dap-ui
    'jay-babu/mason-nvim-dap.nvim', -- Installs adapters via Mason
    'theHamsta/nvim-dap-virtual-text', -- Inline variable values
    'mfussenegger/nvim-dap-python', -- Python specific helpers
  },
  config = function()
    local dap = require 'dap'
    local ui = require 'dapui'
    local mason_dap = require 'mason-nvim-dap'
    local dap_virtual_text = require 'nvim-dap-virtual-text'

    -- 1. Setup Virtual Text (Inline values)
    dap_virtual_text.setup()

    -- 2. Setup UI
    ui.setup()

    -- 3. Auto-Open/Close UI Listeners
    dap.listeners.before.attach.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      ui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      ui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      ui.close()
    end

    -- 4. Setup Mason-Nvim-DAP
    mason_dap.setup {
      ensure_installed = { 'python' },
      automatic_installation = true,
      handlers = {
        function(config)
          require('mason-nvim-dap').default_setup(config)
        end,
        python = function(config)
          config.adapters = {
            type = 'executable',
            command = vim.fn.exepath 'python3',
            args = { '-m', 'debugpy.adapter' },
          }
          require('mason-nvim-dap').default_setup(config)
        end,
      },
    }

    -- SHARED PYTHON PATH LOGIC (Conda-Aware)
    local function get_python_path()
      -- 1. Check active Conda environment (Env Variable) - BEST METHOD
      if os.getenv 'CONDA_PREFIX' then
        return os.getenv 'CONDA_PREFIX' .. '/bin/python'
      end

      -- 2. Check active Standard Virtual Env (Env Variable)
      if os.getenv 'VIRTUAL_ENV' then
        return os.getenv 'VIRTUAL_ENV' .. '/bin/python'
      end

      -- 3. Check local project folders (standard .venv names)
      local cwd = vim.fn.getcwd()
      if vim.fn.executable(cwd .. '/venv/bin/python') == 1 then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
        return cwd .. '/.venv/bin/python'
      end

      -- 4. Check common Conda installation paths in Home
      local home = os.getenv 'HOME'
      local conda_locations = {
        home .. '/anaconda3/bin/python',
        home .. '/miniconda3/bin/python',
        home .. '/miniforge3/bin/python',
        home .. '/conda/bin/python',
        home .. '/.conda/bin/python',
      }
      for _, path in ipairs(conda_locations) do
        if vim.fn.executable(path) == 1 then
          return path
        end
      end

      -- 5. Fallback to system python
      return '/usr/bin/python'
    end

    -- 5. Python Configurations
    dap.configurations.python = {
      -- Config 1: Standard Launch (No Args)
      {
        type = 'python',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        pythonPath = get_python_path, -- Uses the logic above
      },
      -- Config 2: Launch with Args (For Argparse)
      {
        type = 'python',
        request = 'launch',
        name = 'Launch with Arguments (Prompt)',
        program = '${file}',
        pythonPath = get_python_path, -- Uses the logic above
        args = function()
          local args_string = vim.fn.input 'Script Arguments: '
          return vim.split(args_string, ' +')
        end,
      },
    }

    -- 6. Keymaps
    vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, { desc = 'Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>dc', dap.continue, { desc = 'Continue' })
    vim.keymap.set('n', '<leader>di', dap.step_into, { desc = 'Step Into' })
    vim.keymap.set('n', '<leader>do', dap.step_over, { desc = 'Step Over' })
    vim.keymap.set('n', '<leader>du', dap.step_out, { desc = 'Step Out' })
    vim.keymap.set('n', '<leader>dr', dap.repl.open, { desc = 'Open REPL' })
    vim.keymap.set('n', '<leader>dl', dap.run_last, { desc = 'Run Last' })
    vim.keymap.set('n', '<leader>dq', function()
      dap.terminate()
      ui.close()
      dap_virtual_text.toggle()
    end, { desc = 'Terminate Debug Session' })
  end,
}
