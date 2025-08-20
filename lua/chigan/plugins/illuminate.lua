return {
	"RRethy/vim-illuminate",
	config = function()
		require("illuminate").configure({
			-- Waktu tunggu sebelum highlight (ms)
			delay = 200,

			-- Filetype yang tidak akan di-highlight
			filetypes_denylist = {
				"NvimTree",
				"dirvish",
				"fugitive",
				"TelescopePrompt",
				"gitcommit",
				"help",
			},

			-- Mode yang diizinkan: "v" = visual, "n" = normal, "i" = insert
			modes_denylist = {},

			-- Highlight untuk kata yang mirip tapi beda case (true = tidak peduli case)
			case_insensitive = false,
		})

		-- Navigasi ke highlight berikut & sebelumnya
		vim.keymap.set("n", "]r", require("illuminate").goto_next_reference, { desc = "Next reference" })
		vim.keymap.set("n", "[r", require("illuminate").goto_prev_reference, { desc = "Prev reference" })
	end,
}
