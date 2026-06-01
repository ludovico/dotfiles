-- Custom keymaps
-- User-defined keybindings for specific plugins and workflows

local function setup()
	-- Neorg keymaps
	-- Workspace & navigation
	vim.keymap.set("n", "<leader>nw", "<cmd>Neorg workspace<CR>", { desc = "Neorg workspaces" })
	vim.keymap.set("n", "<leader>ni", "<cmd>Neorg index<CR>", { desc = "Neorg index" })
	vim.keymap.set("n", "<leader>nr", "<cmd>Neorg return<CR>", { desc = "Neorg return" })

	-- Journal
	vim.keymap.set("n", "<leader>nj", "<cmd>Neorg journal today<CR>", { desc = "Journal today" })
	vim.keymap.set("n", "<leader>nJ", "<cmd>Neorg journal yesterday<CR>", { desc = "Journal yesterday" })
	vim.keymap.set("n", "<leader>nN", "<cmd>Neorg journal tomorrow<CR>", { desc = "Journal tomorrow" })

	-- TODO states
	vim.keymap.set("n", "<leader>nt", "<cmd>Neorg todo done<CR>", { desc = "Mark done" })
	vim.keymap.set("n", "<leader>nT", "<cmd>Neorg todo pending<CR>", { desc = "Mark pending" })
	vim.keymap.set("n", "<leader>nh", "<cmd>Neorg todo on_hold<CR>", { desc = "Mark on-hold" })

	-- Utilities
	vim.keymap.set("n", "<leader>nm", "<cmd>Neorg mode norg<CR>", { desc = "Reload norg mode" })
	vim.keymap.set("n", "<leader>nq", "<cmd>Neorg toc<CR>", { desc = "Table of contents" })
end

return {
	setup = setup,
}
