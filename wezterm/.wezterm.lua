local wezterm = require("wezterm")
local mux = wezterm.mux
local action = wezterm.action

-- Startup: Maximize the window immediately
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():maximize()
end)

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- [[ GENERAL SETTINGS ]]
config.default_domain = "WSL:Ubuntu"
config.default_cwd = "/home/vu2002123"
config.term = "wezterm"

-- [[ APPEARANCE ]]
-- Default to Light Mode
config.color_scheme = "Catppuccin Latte"
config.font = wezterm.font("IosevkaTerm Nerd Font", { weight = "Bold" })
config.font_size = 11.0
config.line_height = 1.2
config.window_decorations = "RESIZE"

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

	-- 5. THEME TOGGLE (The F11 Trick)
	{
		key = "t",
		mods = "LEADER",
		action = wezterm.action_callback(function(window, pane)
			-- Get current overrides
			local overrides = window:get_config_overrides() or {}

			-- Logic: Toggle between Dark (Gruvbox) and Light (Catppuccin)
			if overrides.color_scheme == "Catppuccin Latte" then
				-- Switch to DARK
				overrides.color_scheme = "Gruvbox Material (Gogh)"
				overrides.font = wezterm.font("IosevkaTerm Nerd Font", { weight = "DemiBold" })
			else
				-- Switch to LIGHT
				overrides.color_scheme = "Catppuccin Latte"
				-- Use "Bold" for light mode to improve contrast on 1080p
				overrides.font = wezterm.font("IosevkaTerm Nerd Font", { weight = "Bold" })
			end

			-- Apply WezTerm changes
			window:set_config_overrides(overrides)

			-- SEND F11 to the terminal (so Neovim hears it)
			window:perform_action(action.SendKey({ key = "F11" }), pane)
		end),
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
