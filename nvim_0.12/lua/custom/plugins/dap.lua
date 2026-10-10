vim.pack.add({
	"https://github.com/mfussenegger/nvim-dap",
	"https://github.com/rcarriga/nvim-dap-ui",
	"https://github.com/nvim-neotest/nvim-nio",
	"https://github.com/jay-babu/mason-nvim-dap.nvim",
	"https://github.com/theHamsta/nvim-dap-virtual-text",
	"https://github.com/mfussenegger/nvim-dap-python",
})

local dap = require("dap")
local ui = require("dapui")
local mason_dap = require("mason-nvim-dap")
local dap_virtual_text = require("nvim-dap-virtual-text")

dap_virtual_text.setup({})
ui.setup({})

dap.listeners.before.attach.dapui_config = ui.open
dap.listeners.before.launch.dapui_config = ui.open
dap.listeners.before.event_terminated.dapui_config = ui.close
dap.listeners.before.event_exited.dapui_config = ui.close

mason_dap.setup({
	ensure_installed = { "python" },
	automatic_installation = true,
	handlers = {
		function(config)
			require("mason-nvim-dap").default_setup(config)
		end,
		python = function(config)
			config.adapters = {
				type = "executable",
				command = vim.fn.exepath("python3"),
				args = { "-m", "debugpy.adapter" },
			}
			require("mason-nvim-dap").default_setup(config)
		end,
	},
})

local function get_python_path()
	local conda_prefix = os.getenv("CONDA_PREFIX")
	if conda_prefix then
		return conda_prefix .. "/bin/python"
	end
	local virtual_env = os.getenv("VIRTUAL_ENV")
	if virtual_env then
		return virtual_env .. "/bin/python"
	end

	local cwd = vim.fn.getcwd()
	for _, path in ipairs({ cwd .. "/venv/bin/python", cwd .. "/.venv/bin/python" }) do
		if vim.fn.executable(path) == 1 then
			return path
		end
	end

	local user_home = os.getenv("HOME") or ""
	for _, directory in ipairs({ "anaconda3", "miniconda3", "miniforge3", "conda", ".conda" }) do
		local path = user_home .. "/" .. directory .. "/bin/python"
		if vim.fn.executable(path) == 1 then
			return path
		end
	end
	return "/usr/bin/python"
end

dap.configurations.python = {
	{
		type = "python",
		request = "launch",
		name = "Launch file",
		program = "${file}",
		pythonPath = get_python_path,
	},
	{
		type = "python",
		request = "launch",
		name = "Launch with Arguments (Prompt)",
		program = "${file}",
		pythonPath = get_python_path,
		args = function()
			return vim.split(vim.fn.input("Script Arguments: "), " +")
		end,
	},
}

vim.keymap.set("n", "<leader>dt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>du", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "Open REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "Run Last" })
vim.keymap.set("n", "<leader>dq", function()
	dap.terminate()
	ui.close()
end, { desc = "Terminate Debug Session" })
