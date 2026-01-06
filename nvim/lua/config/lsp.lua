-- LSP configuration module
-- Handles Language Server Protocol setup and configuration

local function setup()
	-- LSP servers and clients are able to communicate to each other what features they support.
	-- By default, Neovim doesn't support everything that is in the LSP specification.
	-- When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
	-- So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

	local lspconfig = require("lspconfig")
	local util = require("lspconfig.util")

	-- Check whether it's a deno project or not
	local is_deno_project = function()
		local deno_files = { "deno.json", "deno.jsonc", "deno.lock" }

		for _, filepath in ipairs(deno_files) do
			filepath = table.concat({ vim.fn.getcwd(), filepath }, "/")

			if vim.uv.fs_stat(filepath) ~= nil then
				return true
			end
		end

		return false
	end

	-- LSP server configurations
	local servers = {
		denols = {
			root_dir = function(fname)
				-- Only start denols if we're in a Deno project
				-- First check for Deno project files
				local deno_root = util.root_pattern("deno.json", "deno.jsonc")(fname)
				if deno_root then
					-- Double-check: if we also find tsconfig.json or package.json in the same root,
					-- this might be a mixed project, but deno.json takes precedence
					return deno_root
				end
				-- Explicitly return nil to prevent denols from starting in non-Deno projects
				-- This prevents denols from starting in Node.js projects
				return nil
			end,
			single_file_support = false,
			init_options = {
				lint = true,
				unstable = false,
			},
			settings = {
				deno = {
					enable = true,
				},
			},
		},
		ts_ls = {
			root_dir = function(fname)
				-- If we're in a Deno project, don't start ts_ls here
				if util.root_pattern("deno.json", "deno.jsonc")(fname) then
					return nil
				end

				-- Otherwise, use normal TS/JS project roots
				return util.root_pattern("tsconfig.json", "package.json", "jsconfig.json", ".git")(fname)
			end,

			single_file_support = false,
			on_attach = function(client)
				-- strongly recommended: avoid formatter fights
				client.server_capabilities.documentFormattingProvider = false
				client.server_capabilities.documentRangeFormattingProvider = false
			end,
		},
		lua_ls = {
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
					-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
					-- diagnostics = { disable = { 'missing-fields' } },
				},
			},
		},
		eslint = {
			-- Find the nearest eslint config first; fall back to package.json / .git
			root_dir = util.root_pattern(
				"eslint.config.js",
				".eslintrc",
				".eslintrc.js",
				".eslintrc.cjs",
				".eslintrc.json",
				"package.json",
				".git"
			),

			settings = {
				-- Critical for monorepos: choose the right package dir automatically
				workingDirectories = { mode = "auto" },
				eslint = {
					enable = not is_deno_project(),
				},
			},

			on_attach = function(_, bufnr)
				-- optional: fix on save (only triggers where eslint is active)
				vim.api.nvim_create_autocmd("BufWritePre", {
					buffer = bufnr,
					command = "EslintFixAll",
				})
			end,
		},
	}

	-- Prevent denols from attaching to non-Deno projects
	-- This runs both on startup and when LSP attaches
	local function stop_denols_if_not_deno_project(bufnr)
		bufnr = bufnr or 0
		local fname = vim.api.nvim_buf_get_name(bufnr)
		if fname == "" then
			return
		end
		local deno_root = util.root_pattern("deno.json", "deno.jsonc")(fname)
		if not deno_root then
			-- Check all denols clients and stop them if they're attached to this buffer
			local clients = vim.lsp.get_clients({ bufnr = bufnr, name = "denols" })
			for _, client in ipairs(clients) do
				vim.notify("Stopping denols - not a Deno project", vim.log.levels.WARN)
				vim.lsp.stop_client(client.id, true)
			end
		end
	end

	-- Check on startup for any incorrectly attached denols clients
	vim.api.nvim_create_autocmd("VimEnter", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-deno-startup-check", { clear = true }),
		callback = function()
			vim.schedule(function()
				for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
					if vim.api.nvim_buf_is_valid(bufnr) then
						local ftype = vim.api.nvim_buf_get_option(bufnr, "filetype")
						if ftype == "typescript" or ftype == "typescriptreact" or ftype == "javascript" or ftype == "javascriptreact" then
							stop_denols_if_not_deno_project(bufnr)
						end
					end
				end
			end)
		end,
	})

	-- Prevent denols from attaching to non-Deno projects
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-deno-guard", { clear = true }),
		callback = function(event)
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client.name == "denols" then
				stop_denols_if_not_deno_project(event.buf)
			end
		end,
	})

	-- This function gets run when an LSP attaches to a particular buffer.
	vim.api.nvim_create_autocmd("LspAttach", {
		group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
		callback = function(event)
			-- Helper function to create mappings
			local map = function(keys, func, desc, mode)
				mode = mode or "n"
				vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
			end

			-- Jump to the definition of the word under your cursor.
			map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")

			-- Find references for the word under your cursor.
			map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")

			-- Jump to the implementation of the word under your cursor.
			map("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")

			map("gh", vim.diagnostic.open_float, "Show line diagnostic")

			-- Jump to the type of the word under your cursor.
			map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

			-- Fuzzy find all the symbols in your current document.
			map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")

			-- Fuzzy find all the symbols in your current workspace.
			map(
				"<leader>ws",
				require("telescope.builtin").lsp_dynamic_workspace_symbols,
				"[W]orkspace [S]ymbols"
			)

			-- Rename the variable under your cursor.
			map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")

			-- Execute a code action.
			map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })

			-- Goto Declaration.
			map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")

			-- Highlight references of the word under your cursor
			local client = vim.lsp.get_client_by_id(event.data.client_id)
			if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
				local highlight_augroup =
					vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
				vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.document_highlight,
				})

				vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
					buffer = event.buf,
					group = highlight_augroup,
					callback = vim.lsp.buf.clear_references,
				})

				vim.api.nvim_create_autocmd("LspDetach", {
					group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
					callback = function(event2)
						vim.lsp.buf.clear_references()
						vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
					end,
				})
			end

			-- Toggle inlay hints
			if client and client.supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint) then
				map("<leader>th", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
				end, "[T]oggle Inlay [H]ints")
			end
		end,
	})

	-- Ensure the servers and tools above are installed
	require("mason").setup()

	-- You can add other tools here that you want Mason to install
	local ensure_installed = vim.tbl_keys(servers or {})
	vim.list_extend(ensure_installed, {
		"stylua", -- Used to format Lua code
	})
	require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

	require("mason-lspconfig").setup({
		handlers = {
			function(server_name)
				local server = servers[server_name] or {}
				-- This handles overriding only values explicitly passed
				-- by the server configuration above.
				server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
				require("lspconfig")[server_name].setup(server)
			end,
		},
	})
end

return {
	setup = setup,
}
