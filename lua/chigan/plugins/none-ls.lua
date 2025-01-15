return {
	"nvimtools/none-ls.nvim",
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.code_actions.gomodifytags,
				null_ls.builtins.code_actions.impl,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.gofumpt,
				null_ls.builtins.formatting.black,
				null_ls.builtins.diagnostics.markdownlint_cli2,
				null_ls.builtins.formatting.phpcsfixer,
				null_ls.builtins.diagnostics.phpcs,
			},
		})

		vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
	end,
}
