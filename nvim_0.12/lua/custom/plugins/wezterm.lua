vim.pack.add({
	"https://github.com/willothy/wezterm.nvim",
	"https://github.com/catppuccin/nvim",
	"https://github.com/sainnhe/gruvbox-material",
})

local wezterm = require("wezterm")
function wezterm.set_user_var(name, value)
	local value_type = type(value)
	if value_type == "table" then
		value = vim.json.encode(value)
	elseif value_type == "function" or value_type == "thread" then
		error("cannot serialize " .. value_type)
	elseif value_type == "boolean" then
		value = value and "true" or "false"
	elseif value_type == "nil" then
		value = ""
	end

	local template = "\x1b]1337;SetUserVar=%s=%s\a"
	if os.getenv("TMUX") then
		template = "\x1bPtmux;\x1b\x1b]1337;SetUserVar=%s=%s\a\x1b\\"
	end
	vim.api.nvim_chan_send(vim.v.stderr, template:format(name, vim.base64.encode(tostring(value))))
end

vim.keymap.set("n", "<leader>tt", function()
	local is_dark = vim.o.background == "dark"
	local target_wez = is_dark and "Catppuccin Latte" or "Gruvbox Material (Gogh)"
	local target_bg = is_dark and "light" or "dark"
	wezterm.set_user_var("color_scheme", target_wez)
	vim.o.background = target_bg

	if target_bg == "light" then
		require("catppuccin").setup({ flavour = "latte" })
		vim.cmd.colorscheme("catppuccin")
	else
		vim.g.gruvbox_material_background = "medium"
		vim.cmd.colorscheme("gruvbox-material")
	end

	local cache_path = vim.fn.stdpath("config") .. "/lua/custom/saved_theme.lua"
	local file = io.open(cache_path, "w")
	if file then
		file:write("return '" .. target_bg .. "'")
		file:close()
	end
	vim.notify("Theme toggled to " .. (target_bg == "light" and "Catppuccin Latte" or "Gruvbox Dark"))
end, { desc = "Toggle Theme (Catppuccin/Gruvbox)" })
