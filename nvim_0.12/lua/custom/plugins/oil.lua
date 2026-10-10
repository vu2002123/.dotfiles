vim.pack.add({
	"https://github.com/stevearc/oil.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
})

require("oil").setup({
	default_file_explorer = true,
	columns = { "icon" },
	view_options = { show_hidden = true },
	float = {
		padding = 2,
		max_width = 0,
		max_height = 0,
		border = "rounded",
		win_options = { winblend = 0 },
	},
})

vim.keymap.set("n", "-", function()
	require("oil").toggle_float()
end, { desc = "Open parent directory (Float)" })
