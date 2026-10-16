local wezterm = require("wezterm")
local mux = wezterm.mux
local action = wezterm.action

-- Startup: Maximize the window immediately
-- wezterm.on("gui-startup", function(cmd)
-- -- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	window:gui_window():maximize()
-- end)

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- [[ GENERAL SETTINGS ]]
config.term = "xterm-256color"
config.adjust_window_size_when_changing_font_size = false

-- [[ APPEARANCE ]]
-- Default to Light Mode
config.color_scheme = "rose-pine-dawn"
config.font = wezterm.font("IosevkaTerm Nerd Font", { weight = "Bold" })
config.font_size = 14.0
config.line_height = 1.1

-- Tab Bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- Padding
config.window_padding = {
	top = 10,
	bottom = 10,
	left = 10,
	right = 10,
}

-- [[ KEYBINDINGS ]]
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = {
	-- 1. Pane Splitting
	{
		key = "\\",
		mods = "LEADER",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "-",
		mods = "LEADER",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	-- 2. Pane Zooming
	{
		key = "m",
		mods = "LEADER",
		action = action.TogglePaneZoomState,
	},

	-- 3. Copy Mode
	{ key = "[", mods = "LEADER", action = action.ActivateCopyMode },

	-- 4. Tab Management
	{
		key = "c",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "p",
		mods = "LEADER",
		action = action.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "LEADER",
		action = action.ActivateTabRelative(1),
	},
	{
		key = "x",
		mods = "LEADER",
		action = action.CloseCurrentTab({ confirm = false }),
	},
}

-- 6. Quick Tab Switching (1-9)
for i = 1, 9 do
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = action.ActivateTab(i - 1),
	})
end

return config
