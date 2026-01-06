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
		enabled = false,
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
	{
		"nvim-neorg/neorg",
		lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		-- config = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- loads a sensible baseline of modules
					["core.concealer"] = {
						config = {
							icon_preset = "varied", -- "basic" is also a nice choice
							-- folds_opened = "auto", -- optional (see concealer docs)
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
							strategy = "flat", -- daily files directly in /journal
						},
					},
					["core.completion"] = {
						config = {
							engine = "nvim-cmp", -- or "nvim-compe"
						},
					},
				},
			})
		end,
	},
	---@type LazySpec
	{
		"mikavilpas/yazi.nvim",
		version = "*", -- use the latest stable version
		event = "VeryLazy",
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = true },
		},
		keys = {
			-- 👇 in this section, choose your own keymappings!
			{
				"<leader>-",
				mode = { "n", "v" },
				"<cmd>Yazi<cr>",
				desc = "Open yazi at the current file",
			},
			{
				-- Open in the current working directory
				"<leader>cw",
				"<cmd>Yazi cwd<cr>",
				desc = "Open the file manager in nvim's working directory",
			},
			{
				"<c-up>",
				"<cmd>Yazi toggle<cr>",
				desc = "Resume the last yazi session",
			},
		},
		---@type YaziConfig | {}
		opts = {
			-- if you want to open yazi instead of netrw, see below for more info
			open_for_directories = false,
			keymaps = {
				show_help = "<f1>",
			},
		},
		-- 👇 if you use `open_for_directories=true`, this is recommended
		init = function()
			-- mark netrw as loaded so it's not loaded at all.
			--
			-- More details: https://github.com/mikavilpas/yazi.nvim/issues/802
			vim.g.loaded_netrwPlugin = 1
		end,
	},
	{
		"sigmasd/deno-nvim",
	},
}
