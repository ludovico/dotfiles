-- Core keymaps configuration
-- See `:help vim.keymap.set()` for more information

local function setup()
	-- Clear highlights on search when pressing <Esc> in normal mode
	vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

	-- Diagnostic keymaps
	vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

	-- Terminal mode
	-- Exit terminal mode with <Esc><Esc>
	vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

	-- Window navigation
	-- Use CTRL+<hjkl> to switch between windows
	vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
	vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
	vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
	vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

	-- Disable arrow keys (optional - uncomment to enable)
	-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
	-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
	-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
	-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
end

return {
	setup = setup,
}
