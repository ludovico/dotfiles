-- Plugin loader
-- This file loads all plugin modules organized by category

return {
	{ import = "plugins.core" },
	{ import = "plugins.lsp" },
	{ import = "plugins.ui" },
	{ import = "plugins.editor" },
	{ import = "plugins.languages" },
	{ import = "plugins.tools" },
	{ import = "plugins.notes" },
	{ import = "kickstart.plugins.neo-tree" },
	{ import = "custom.plugins" },
}
