return {
	-- Add the blade-nav.nvim plugin which provides Goto File capabilities
	-- for Blade files.
	"ricardoramirezr/blade-nav.nvim",
	dependencies = {
		"hrsh7th/nvim-cmp",
		"jwalton512/vim-blade",
	},
	ft = { "blade", "php" }, -- optional, improves startup time
}
