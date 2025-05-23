return {
	"numToStr/Navigator.nvim",
	config = function(opts)
		require("Navigator").setup(opts)
		vim.keymap.set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>")
		vim.keymap.set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>")
		vim.keymap.set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>")
		vim.keymap.set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>")
	end,
}
