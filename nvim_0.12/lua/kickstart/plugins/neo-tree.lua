vim.pack.add({
	"https://github.com/nvim-neo-tree/neo-tree.nvim",
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/MunifTanjim/nui.nvim",
})

require("neo-tree").setup({
	filesystem = {
		window = { mappings = { ["\\"] = "close_window" } },
	},
})
vim.keymap.set("n", "\\", "<cmd>Neotree reveal<cr>", { desc = "NeoTree reveal", silent = true })
