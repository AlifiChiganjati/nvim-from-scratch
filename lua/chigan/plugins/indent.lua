return {
	"lukas-reineke/indent-blankline.nvim",
	event = { "BufReadPre", "BufNewFile" },
	main = "ibl",
	opts = {
		indent = {
			char = "┊",
			tab_char = "┊",
			highlight = { "Function", "Label" },
			smart_indent_cap = true,
			priority = 2,
			repeat_linebreak = false,
		},
		whitespace = {
			highlight = { "Function", "Label" },
			remove_blankline_trail = true,
		},
		scope = {
			enabled = true,
			show_start = true,
			show_end = false,
			highlight = { "Function", "Label" },
			show_exact_scope = true,
		},
	},
}
