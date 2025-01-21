-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{
		"kdheepak/lazygit.nvim",
		lazy = true,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		-- optional for floating window border decoration
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		-- setting the keybinding for LazyGit with 'keys' is recommended in
		-- order to load the plugin when the command is run for the first time
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},

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
	{
		"tools-life/taskwiki",
		lazy = false,
		init = function()
			vim.g.taskwiki_markup_syntax = "markdown"
		end,
	},
	{
		"bullets-vim/bullets.vim",
		lazy = false,
	},
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		-- tag = "v2.15", -- uncomment to pin to a specific release
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "skim"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "",
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				options = {
					"-pdf", -- Compile to PDF
					"-shell-escape", -- Allow external commands
					"-verbose", -- Verbose output
					"-file-line-error", -- Detailed error messages
					"-synctex=1", -- SyncTeX for source-pdf navigation
					"-interaction=nonstopmode", -- Nonstop mode (continue after errors)
					"-use-make", -- Use makeindex for nomenclature
				},
				-- Add custom command to handle the nomenclature index
				hooks = {},
			}
		end,
	},
	{
		"jalvesaq/zotcite",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("zotcite").setup({
				-- your options here (see doc/zotcite.txt)
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				sync_install = true,
				ensure_installed = {
					"html",
					"latex",
					"markdown",
					"markdown_inline",
					"yaml",
				},
				highlight = {
					enable = true,
				},
				indent = {
					enable = true,
				},
			})
			vim.o.foldmethod = "expr"
			vim.o.foldexpr = "nvim_treesitter#foldexpr()"
			vim.o.foldenable = false
		end,
	},
	{
		"dart-lang/dart-vim-plugin",
	},
}
