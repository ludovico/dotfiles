-- Ollama-powered autocomplete via minuet-ai.nvim
-- Uses local qwen2.5-coder FIM model for Copilot-style ghost text

return {
	{
		"milanglacier/minuet-ai.nvim",
		event = "InsertEnter",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("minuet").setup({
				provider = "openai_fim_compatible",
				n_completions = 1,
				context_window = 2048,
				request_timeout = 3,
				throttle = 400,
				debounce = 200,
				provider_options = {
					openai_fim_compatible = {
						api_key = "TERM",
						name = "Ollama",
						end_point = "http://localhost:11434/v1/completions",
						model = "qwen2.5-coder:1.5b",
						optional = {
							max_tokens = 128,
							top_p = 0.9,
							stop = { "<|endoftext|>", "<|fim_prefix|>", "<|fim_middle|>", "<|fim_suffix|>", "<|file_sep|>" },
						},
					},
				},
				virtualtext = {
					auto_trigger_ft = { "*" },
					auto_trigger_ignore_ft = {
						"yaml", "markdown", "help", "gitcommit",
						"gitrebase", "hgcommit", "svn", "cvs",
					},
					keymap = {
						accept = "<C-j>",
						accept_line = "<C-k>",
						prev = "<C-,>",
						next = "<C-.>",
						dismiss = "<C-e>",
					},
					show_on_completion_menu = false,
				},
			})
		end,
	},
}
