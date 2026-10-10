-- Molten was disabled in the lazy.nvim configuration. Set this global before
-- loading custom.plugins to opt in.
if not vim.g.enable_molten then
	return
end

vim.g.molten_auto_open_output = false
vim.g.molten_output_show_more = true
vim.g.molten_image_provider = "none"
vim.g.molten_output_virt_lines = true
vim.g.molten_virt_text_output = true
vim.g.molten_use_border_highlights = true
vim.g.molten_virt_lines_off_by_1 = true
vim.g.molten_auto_image_popup = false
vim.g.molten_output_win_zindex = 50

vim.pack.add({
	{ src = "https://github.com/benlubas/molten-nvim", version = vim.version.range("1.*") },
	"https://github.com/willothy/wezterm.nvim",
})

vim.keymap.set("n", "<leader>mi", "<cmd>MoltenInit<cr>", { silent = true, desc = "Initialize Molten" })
vim.keymap.set("n", "<leader>e", "<cmd>MoltenEvaluateOperator<cr>", { silent = true, desc = "Run operator selection" })
vim.keymap.set("n", "<leader>rl", "<cmd>MoltenEvaluateLine<cr>", { silent = true, desc = "Evaluate line" })
vim.keymap.set("n", "<leader>rr", "<cmd>MoltenReevaluateCell<cr>", { silent = true, desc = "Re-evaluate cell" })
vim.keymap.set("v", "<leader>r", ":<C-u>MoltenEvaluateVisual<cr>gv", { silent = true, desc = "Evaluate selection" })
vim.keymap.set("n", "<leader>oh", "<cmd>MoltenHideOutput<cr>", { silent = true, desc = "Hide output" })
vim.keymap.set("n", "<leader>os", "<cmd>noautocmd MoltenEnterOutput<cr>", { silent = true, desc = "Enter output" })
vim.keymap.set("n", "<leader>md", "<cmd>MoltenDeinit<cr>", { silent = true, desc = "Stop Molten" })

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(event)
		if event.data.spec.name == "molten-nvim" and (event.data.kind == "install" or event.data.kind == "update") then
			vim.cmd("UpdateRemotePlugins")
		end
	end,
})
