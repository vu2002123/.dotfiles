vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks").setup({
	picker = { enabled = true },
	explorer = { enabled = false },
})

local function map(lhs, picker, desc, opts)
	vim.keymap.set("n", lhs, function()
		Snacks.picker[picker](opts)
	end, { desc = desc })
end

map("<leader><leader>", "buffers", "[ ] Find existing buffers")
map("<leader>sf", "files", "[S]earch [F]iles")
map("<leader>sg", "grep", "[S]earch by [G]rep")
map("<leader>s.", "recent", "[S]earch Recent Files ('.')")
map("<leader>gl", "git_log", "[G]it [L]og")
map("<leader>gs", "git_status", "[G]it [S]tatus")
map("<leader>sw", "grep_word", "[S]earch current [W]ord")
map("<leader>s/", "grep", "[S]earch [/] in Open Files", { buffers = true })
map("<leader>s\"", "registers", "[S]earch Registers")
map("<leader>sd", "diagnostics", "[S]earch [D]iagnostics")
map("<leader>sr", "resume", "[S]earch [R]esume")
map("<leader>sh", "help", "[S]earch [H]elp")
map("<leader>sk", "keymaps", "[S]earch [K]eymaps")
map("<leader>ss", "pickers", "[S]earch [S]elect Picker")
map("<leader>/", "lines", "[/] Fuzzily search in current buffer")
map("<leader>sn", "files", "[S]earch [N]eovim files", { cwd = vim.fn.stdpath("config") })
