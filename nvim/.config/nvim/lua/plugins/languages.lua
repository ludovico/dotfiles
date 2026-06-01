-- Language-specific plugins
-- Plugins for specific programming languages and file types

return {
	-- Deno support
	-- Note: We manage denols LSP manually in config/lsp.lua
	-- If deno-nvim is causing conflicts, you can remove this plugin entirely
	-- and rely solely on the manual denols configuration
	{
		"sigmasd/deno-nvim",
		enabled = false, -- Disabled to prevent LSP conflicts - denols is managed manually
		config = function()
			require("deno-nvim").setup({
				-- Disable LSP setup since we're managing it manually in lsp.lua
				lspconfig = false,
			})
		end,
	},

	-- Dart support
	{
		"dart-lang/dart-vim-plugin",
	},

	-- LaTeX support
	{
		"lervag/vimtex",
		lazy = false, -- we don't want to lazy load VimTeX
		init = function()
			vim.g.vimtex_view_method = "skim"
			vim.g.vimtex_compiler_latexmk = {
				build_dir = "",
				callback = 1,
				continuous = 1,
				executable = "latexmk",
				options = {
					"-pdf",
					"-shell-escape",
					"-verbose",
					"-file-line-error",
					"-synctex=1",
					"-interaction=nonstopmode",
					"-use-make",
				},
				hooks = {},
			}
		end,
	},
}
