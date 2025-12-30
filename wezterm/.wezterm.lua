-- ~/.wezterm.lua
local wezterm = require("wezterm")
local mux = wezterm.mux

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():maximize()
end)

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- change config now
config.default_domain = 'WSL:Ubuntu'
config.default_cwd = "/home/vu2002123"
-- Appearance
config.term = "xterm-256color"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 11
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme = "Kanagawa (Gogh)"
config.window_decorations = "RESIZE"

config.window_padding = {
  top = 10,
  bottom = 10,
  left = 10,
  right = 10,
}

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

local action = wezterm.action
local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}
local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "CTRL|SHIFT" or "CTRL",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "CTRL|SHIFT" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 5 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end
config.keys = {
  {
    key = "\\",
    mods = "LEADER",
    action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
  },
  split_nav("move", "h"),
	split_nav("move", "j"),
	split_nav("move", "k"),
	split_nav("move", "l"),
	split_nav("resize", "h"),
	split_nav("resize", "j"),
	split_nav("resize", "k"),
	split_nav("resize", "l"),
  {
    key = "-",
    mods = "LEADER",
    action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
  },
  {
    key = "m",
    mods = "LEADER",
    action = action.TogglePaneZoomState,
  },
  { key = "[", mods = "LEADER", action = action.ActivateCopyMode },
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
}

for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = action.ActivateTab(i - 1),
  })
end

return config
