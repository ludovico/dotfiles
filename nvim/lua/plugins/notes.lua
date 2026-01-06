-- Note-taking and documentation plugins
-- VimWiki, Neorg, TaskWiki, and related tools

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

	-- TaskWiki (TaskWarrior integration)
	{
		"tools-life/taskwiki",
		lazy = false,
		init = function()
			vim.g.taskwiki_markup_syntax = "markdown"
		end,
	},

	-- Bullets (markdown list management)
	{
		"bullets-vim/bullets.vim",
		lazy = false,
		enabled = false, -- Currently disabled
	},

	-- Neorg
	{
		"nvim-neorg/neorg",
		lazy = false,
		version = "*",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {},
					["core.concealer"] = {
						config = {
							icon_preset = "varied",
						},
					},
					["core.dirman"] = {
						config = {
							workspaces = {
								notes = "~/Nextcloud/neorg/notes",
							},
							default_workspace = "notes",
						},
					},
					["core.journal"] = {
						config = {
							workspace = "notes",
							journal_folder = "journal",
							strategy = "flat",
						},
					},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp",
						},
					},
				},
			})
		end,
	},
}
