-- Check if running inside VSCode
if vim.g.vscode then
  -- VSCode extension specific configuration
  -- local format = vscode.to_op(function(ctx)
  --   vscode.action("editor.action.formatSelection", { range = ctx.range })
  -- end)
  -- vim.keymap.set({ "n", "x" }, "gq", format, { expr = true })
  vim.cmd [[
    set linebreak
    set textwidth=72 
    set ignorecase
    set smartcase
    set incsearch
  ]]
else
  -- General Neovim Configuration
  vim.cmd [[
    syntax enable
    set termguicolors
    set relativenumber
    set ignorecase
    set smartcase
    set incsearch
    set hidden
    set foldmethod=manual
    set wildmenu
    set wildmode=list:longest,full
    set hlsearch
    set list
    set listchars=tab:▸\ ,trail:·
    set nojoinspaces
    set scrolloff=8
    set sidescrolloff=8
    set nojoinspaces
  ]]

  -- Basic settings
  vim.opt.expandtab = true
  vim.opt.tabstop = 2
  vim.opt.shiftwidth = 2
  vim.opt.softtabstop = 2
  vim.opt.smartindent = true
  vim.opt.smarttab = true
  vim.opt.encoding = 'utf-8'
  vim.opt.history = 50
  vim.opt.ruler = true

  -- Highlight line numbers
  vim.api.nvim_set_hl(0, 'LineNr', { bold = true, fg = 'DarkGrey', bg = 'NONE' })

  -- Mouse support
  if vim.fn.has('mouse') == 1 then
    vim.opt.mouse = 'a'
  end

  -- Key mappings
  vim.g.mapleader = " "
  vim.api.nvim_set_keymap('n', '<leader>ve', ':edit ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>vr', ':source ~/.config/nvim/init.lua<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('n', '<leader>t', ':NERDTreeFind<CR>', { noremap = true, silent = true })
  vim.api.nvim_set_keymap('', 'gf', ':edit <cfile><cr>', { noremap = true, silent = true })

  -- Plugin management using packer
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  end

  require('packer').startup(function()
    -- List your plugins here
    use 'wbthomason/packer.nvim'  -- Packer can manage itself

    -- Example: Add more plugins as required
    -- use { 'neovim/nvim-lspconfig' }
    -- use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    -- use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
    -- use 'preservim/nerdtree'
  end)

  -- Additional configurations
  vim.g.blamer_enabled = 1
  vim.g.blamer_delay = 200
  vim.g.blamer_show_in_insert_modes = 0
  vim.g.blamer_show_in_visual_modes = 0
end

