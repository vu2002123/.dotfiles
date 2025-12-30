return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.9",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<C-p>", builtin.find_files, {})
			vim.keymap.set("n", "<leader>sg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
		end,
	},
	{
		"nvim-telescope/telescope-ui-select.nvim",
		config = function()
			require("telescope").setup({
        defaults = {
          -- Add the ignore patterns here
          file_ignore_patterns = {
            "%.pdb",
            "%.dat",
            "%.sd",
            "%.mol2",
            "%.sdf",
          }
        },
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown({}),
					},
				},
			})
			require("telescope").load_extension("ui-select")
		end,
	},
}
