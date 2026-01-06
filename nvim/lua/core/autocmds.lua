-- Core autocommands configuration
-- See `:help lua-guide-autocommands` for more information

local function setup()
	local highlight_yank_group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true })

	-- Highlight when yanking (copying) text
	vim.api.nvim_create_autocmd("TextYankPost", {
		desc = "Highlight when yanking (copying) text",
		group = highlight_yank_group,
		callback = function()
			vim.highlight.on_yank()
		end,
	})

	-- VimTeX focus handler
	local function tex_focus_vim()
		os.execute("open -a iTerm")
		vim.cmd("redraw!")
	end

	local vimtex_group = vim.api.nvim_create_augroup("vimtex_event_focus", { clear = true })
	vim.api.nvim_create_autocmd("User", {
		pattern = "VimtexEventViewReverse",
		group = vimtex_group,
		callback = tex_focus_vim,
	})
end

return {
	setup = setup,
}
