-- Treesitter configuration module
-- Handles syntax highlighting and code parsing

local function setup()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
			"bash",
			"c",
			"diff",
			"html",
			"latex",
			"lua",
			"luadoc",
			"markdown",
			"markdown_inline",
			"query",
			"vim",
			"vimdoc",
			"yaml",
		},
		-- Autoinstall languages that are not installed
		auto_install = true,
		highlight = {
			enable = true,
			-- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
			additional_vim_regex_highlighting = { "ruby" },
		},
		indent = { enable = true, disable = { "ruby" } },
	})

	-- Configure folding
	vim.o.foldmethod = "expr"
	vim.o.foldexpr = "nvim_treesitter#foldexpr()"
	vim.o.foldenable = false
end

return {
	setup = setup,
}
