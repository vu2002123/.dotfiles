vim.pack.add({ "https://github.com/Vigemus/iron.nvim" })

local view = require("iron.view")
require("iron.core").setup({
	config = {
		repl_filetype = function(_, ft)
			return ft
		end,
		dap_integration = true,
		repl_open_cmd = {
			view.split.vertical.rightbelow("%40"),
			view.split.rightbelow("%25"),
		},
		repl_definition = {
			python = {
				command = { "ipython" },
				format = require("iron.fts.common").bracketed_paste_python,
			},
		},
	},
	keymaps = {
		toggle_repl_with_cmd_1 = "<leader>rr",
		toggle_repl_with_cmd_2 = "<leader>rh",
		restart_repl = "<leader>rR",
		send_motion = "<leader>r",
		visual_send = "<leader>rv",
		send_file = "<leader>rf",
		send_line = "<leader>rl",
		send_paragraph = "<leader>rp",
		send_until_cursor = "<leader>rc",
		clear = "<leader>cl",
	},
	should_map_plug = false,
	scratch_repl = true,
})
