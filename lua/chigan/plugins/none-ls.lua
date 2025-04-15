return {
	"nvimtools/none-ls.nvim",
	enabled = false,
	-- event = {
	-- 	"BufReadPre",
	-- 	"BufNewFile",
	-- },
	config = function()
		local null_ls = require("null-ls")
		null_ls.setup({
			sources = {
				-- JAVA
				null_ls.builtins.formatting.google_java_format,
				null_ls.builtins.diagnostics.checkstyle.with({
					extra_args = { "-c", "/google_checks.xml" },
				}),
				-- --------------------------------------------
				-- rest of config...
				--php and laravel
				null_ls.builtins.diagnostics.phpstan,
				null_ls.builtins.formatting.pint,
				null_ls.builtins.formatting.blade_formatter,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.prettier,
				null_ls.builtins.formatting.standardrb,
				null_ls.builtins.formatting.htmlbeautifier,
				null_ls.builtins.formatting.beautysh,
				null_ls.builtins.formatting.buf,
				null_ls.builtins.formatting.buf,
				null_ls.builtins.formatting.buf,
				null_ls.builtins.formatting.buf,
				null_ls.builtins.formatting.buf,
			},
		})

		vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, {})
	end,
}
