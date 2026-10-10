vim.pack.add({ "https://github.com/lewis6991/gitsigns.nvim" })

require("gitsigns").setup({
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")
		local function map(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
		end

		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, "Jump to next git [c]hange")
		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, "Jump to previous git [c]hange")
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Git [s]tage hunk")
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, "Git [r]eset hunk")
		map("n", "<leader>hs", gitsigns.stage_hunk, "Git [s]tage hunk")
		map("n", "<leader>hr", gitsigns.reset_hunk, "Git [r]eset hunk")
		map("n", "<leader>hS", gitsigns.stage_buffer, "Git [S]tage buffer")
		map("n", "<leader>hu", gitsigns.undo_stage_hunk, "Git [u]ndo stage hunk")
		map("n", "<leader>hR", gitsigns.reset_buffer, "Git [R]eset buffer")
		map("n", "<leader>hp", gitsigns.preview_hunk, "Git [p]review hunk")
		map("n", "<leader>hb", gitsigns.blame_line, "Git [b]lame line")
		map("n", "<leader>hd", gitsigns.diffthis, "Git [d]iff against index")
		map("n", "<leader>hD", function()
			gitsigns.diffthis("@")
		end, "Git [D]iff against last commit")
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame, "[T]oggle git [b]lame")
		map("n", "<leader>tD", gitsigns.preview_hunk_inline, "[T]oggle git [D]eleted")
	end,
})
