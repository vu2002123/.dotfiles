-- Native Neovim 0.12 package modules. Keep dependency providers before consumers.
local modules = {
	"snacks",
	"clipboard",
	"context",
	"csvview",
	"dap",
	"iron",
	"jupytext",
	"marp",
	"md_render",
	"molten_python",
	"oil",
	"preview",
	"tmux",
	"vimtex",
	"wezterm",
}

for _, module in ipairs(modules) do
	require("custom.plugins." .. module)
end
