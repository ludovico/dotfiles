-- Note-taking and documentation plugins
-- VimWiki and related tools

return {
	-- VimWiki
	{
		"vimwiki/vimwiki",
		keys = { "<leader>ww", "<leader>wt" },
		init = function()
			vim.g.vimwiki_list = {
				{ path = "~/Nextcloud/wiki", syntax = "markdown", ext = ".md", links_space_char = "-" },
			}
			vim.g.vimwiki_ext2syntax = { [".md"] = "markdown", [".markdown"] = "markdown", [".mdown"] = "markdown" }
			vim.g.vimwiki_use_mouse = 1
			vim.g.vimwiki_markdown_link_ext = 1
		end,
	},

	-- Bullets (markdown list management)
	{
		"bullets-vim/bullets.vim",
		lazy = false,
		enabled = false, -- Currently disabled
	},

	-- Zen Mode (distraction-free writing)
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{ "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
		},
		dependencies = { "folke/twilight.nvim" },
		opts = {},
	},

	-- Twilight (dim inactive code)
	{
		"folke/twilight.nvim",
		cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
		opts = {
			context = 10,
			treesitter = false, -- no nvim-treesitter installed; fall back to expand/context
			expand = { "function", "method", "table", "if_statement" },
		},
	},

	-- Pencil (prose writing for markdown/wiki)
	{
		"preservim/vim-pencil",
		ft = { "markdown", "vimwiki", "text" },
		init = function()
			vim.g["pencil#wrapModeDefault"] = "soft"
		end,
	},
}
