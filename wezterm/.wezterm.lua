local wezterm = require("wezterm")
local mux = wezterm.mux
local action = wezterm.action

-- Startup: Maximize the window immediately
-- wezterm.on("gui-startup", function(cmd)
-- 	local tab, pane, window = mux.spawn_window(cmd or {})
-- 	window:gui_window():maximize()
-- end)

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- [[ GENERAL SETTINGS ]]
-- config.default_domain = "WSL:Ubuntu"
-- config.default_cwd = "/home/vu2002123"
config.term = "xterm-256color"
config.front_end = "WebGpu" -- Bypasses older X11 hardware detection
config.scrollback_lines = 3000 -- Lowering this from default saves RAM/init time
config.enable_wayland = false -- Stops checking for Wayland (you are on i3/X11)
config.check_for_updates = false -- Stops a network check on startup

-- [[ APPEARANCE ]]
-- Default to Light Mode
config.color_scheme = "Catppuccin Latte"
config.font = wezterm.font("IosevkaTerm Nerd Font", { weight = "Bold" })
config.font_size = 14.0
config.line_height = 1.2
config.window_decorations = "NONE"

-- Tab Bar
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

-- Padding
config.window_padding = {
	top = 5,
	bottom = 5,
	left = 5,
	right = 5,
}

-- [[ KEYBINDINGS ]]
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

-- Listener for Neovim (or other apps)
wezterm.on("user-var-changed", function(window, pane, name, value)
	if name == "color_scheme" then
		-- Default to "DemiBold" (for Dark / Gruvbox)
		local new_weight = "DemiBold"

		-- If switching to Light mode, force "Bold"
		if value == "Catppuccin Latte" then
			new_weight = "Bold"
		end

		-- Apply both simultaneously to prevent flickering or overrides clearing
		window:set_config_overrides({
			color_scheme = value,
			font = wezterm.font("IosevkaTerm Nerd Font", { weight = new_weight }),
		})
	end
end)

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
