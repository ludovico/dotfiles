-- Core Neovim options configuration
-- See `:help vim.opt` for more information

-- Leader key setup (must be before plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.keymap.set("n", "<LocalLeader>,", ",")

-- Nerd Font detection
vim.g.have_nerd_font = false

-- Line numbers
vim.opt.number = true
-- vim.opt.relativenumber = true -- Uncomment if you want relative line numbers

-- Mouse support
vim.opt.mouse = "a"

-- UI options
vim.opt.showmode = false -- Don't show mode, already in status line
vim.opt.signcolumn = "yes" -- Keep signcolumn on by default
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.scrolloff = 10 -- Minimal number of screen lines to keep above/below cursor

-- Clipboard
-- Sync clipboard between OS and Neovim
vim.schedule(function()
	vim.opt.clipboard = "unnamedplus"
end)

-- Indentation
vim.opt.breakindent = true -- Enable break indent

-- Undo
vim.opt.undofile = true -- Save undo history

-- Search
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true -- Unless \C or capital letters in search term
vim.opt.inccommand = "split" -- Preview substitutions live, as you type

-- Performance
vim.opt.updatetime = 250 -- Decrease update time
vim.opt.timeoutlen = 300 -- Decrease mapped sequence wait time (displays which-key popup sooner)

-- Window splitting
vim.opt.splitright = true -- Configure how new splits should be opened
vim.opt.splitbelow = true

-- Whitespace display
vim.opt.list = true -- Sets how neovim will display certain whitespace characters
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Conceal (for LaTeX and other markup)
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
