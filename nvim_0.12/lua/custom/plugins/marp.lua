vim.pack.add({ "https://github.com/mpas/marp-nvim" })
require("marp").setup({
	port = 8080,
	wait_for_response_timeout = 30,
	wait_for_response_delay = 1,
})
