# Neovim Configuration

This is a modular, maintainable Neovim configuration organized by functionality.

## Structure

```
nvim/
├── init.lua                 # Main entry point - minimal bootstrap
├── lua/
│   ├── core/               # Core Neovim settings
│   │   ├── options.lua     # Vim options (line numbers, clipboard, etc.)
│   │   ├── keymaps.lua     # Core keybindings
│   │   └── autocmds.lua    # Core autocommands
│   ├── config/             # Configuration modules
│   │   ├── lsp.lua        # LSP server configurations
│   │   └── treesitter.lua  # Treesitter configuration
│   ├── plugins/            # Plugin configurations organized by category
│   │   ├── init.lua       # Plugin loader (imports all plugin modules)
│   │   ├── core.lua       # Essential plugins (telescope, which-key)
│   │   ├── lsp.lua        # LSP-related plugins
│   │   ├── ui.lua         # UI plugins (colorscheme, statusline)
│   │   ├── editor.lua     # Editor enhancements (treesitter, autopairs)
│   │   ├── languages.lua  # Language-specific plugins
│   │   ├── tools.lua      # Utility tools (git, file manager)
│   │   └── notes.lua      # Note-taking plugins (vimwiki, neorg)
│   ├── keymaps/           # Custom keymap modules
│   │   └── custom.lua     # User-defined keybindings
│   ├── custom/            # User customizations
│   │   └── plugins/       # Additional custom plugins
│   └── kickstart/         # Kickstart.nvim plugin modules
│       └── plugins/       # Individual kickstart plugin configs
└── .neoconf.json          # Neoconf configuration
```

## Key Features

- **Modular Structure**: Configuration is split into logical modules
- **Easy to Maintain**: Each plugin category has its own file
- **Clear Separation**: Core settings, plugins, and keymaps are separated
- **Extensible**: Easy to add new plugins or modify existing ones

## Adding New Plugins

### To an existing category:
Edit the appropriate file in `lua/plugins/` (e.g., `tools.lua` for utility plugins)

### To create a new category:
1. Create a new file in `lua/plugins/` (e.g., `lua/plugins/mycategory.lua`)
2. Add `{ import = "plugins.mycategory" }` to `lua/plugins/init.lua`

### For custom plugins:
Add them to `lua/custom/plugins/init.lua`

## Configuration Modules

### Core (`lua/core/`)
- **options.lua**: All Neovim options (line numbers, clipboard, search, etc.)
- **keymaps.lua**: Core keybindings (window navigation, diagnostics, etc.)
- **autocmds.lua**: Core autocommands (yank highlighting, etc.)

### Config (`lua/config/`)
- **lsp.lua**: LSP server configurations and keymaps
- **treesitter.lua**: Treesitter parser configurations

### Plugins (`lua/plugins/`)
- **core.lua**: Essential plugins (sleuth, which-key, telescope)
- **lsp.lua**: LSP plugins (lspconfig, mason, cmp, conform)
- **ui.lua**: UI enhancements (colorscheme, todo-comments, mini.nvim)
- **editor.lua**: Editor improvements (treesitter, autopairs)
- **languages.lua**: Language-specific plugins (deno, dart, vimtex)
- **tools.lua**: Utility tools (gitsigns, lazygit, yazi)
- **notes.lua**: Note-taking (vimwiki, neorg, taskwiki)

## Keybindings

### Leader Key
- `<Space>` is the main leader key
- `,` is the local leader key

### Common Keymaps
- `<leader>s*` - Telescope search operations
- `<leader>h*` - Git operations (via gitsigns)
- `<leader>n*` - Neorg operations
- `<leader>lg` - LazyGit
- `<leader>-` - Yazi file manager

See `lua/core/keymaps.lua` and `lua/keymaps/custom.lua` for all keybindings.

## Plugin Manager

This configuration uses [lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

- `:Lazy` - Open the plugin manager UI
- `:Lazy update` - Update all plugins
- `:Lazy sync` - Install missing plugins
