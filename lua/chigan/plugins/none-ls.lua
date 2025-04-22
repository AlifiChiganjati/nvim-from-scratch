return {
	"nvimtools/none-ls.nvim",
	enabled = false,
	config = function()
		local null_ls = require("null-ls")
		local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

		null_ls.setup({
			sources = {
				-- JAVA
				null_ls.builtins.formatting.google_java_format,
				null_ls.builtins.diagnostics.checkstyle.with({
					extra_args = { "-c", "/google_checks.xml" },
				}),

				-- PHP
				null_ls.builtins.formatting.pint,
				null_ls.builtins.diagnostics.phpstan,

				-- Blade
				null_ls.builtins.formatting.blade_formatter,

				-- Lua
				null_ls.builtins.formatting.stylua,

				-- Prettier family
				null_ls.builtins.formatting.prettier,

				-- HTML
				null_ls.builtins.formatting.htmlbeautifier,

				-- Protocol Buffers
				null_ls.builtins.formatting.buf,

				-- Docker
				null_ls.builtins.diagnostics.hadolint,

				-- Markdown
				null_ls.builtins.diagnostics.markdownlint,

				-- JS/TS Linting
				null_ls.builtins.diagnostics.eslint_d,

				-- Terraform
				null_ls.builtins.diagnostics.tflint,

				-- Ruby
				null_ls.builtins.formatting.standardrb,

				-- Shell
				null_ls.builtins.formatting.beautysh,
				null_ls.builtins.diagnostics.shellcheck,

				-- YAML
				null_ls.builtins.formatting.yamlfix,

				-- TOML
				null_ls.builtins.formatting.taplo,

				-- XML
				null_ls.builtins.formatting.xmllint,

				-- Go
				null_ls.builtins.formatting.gofmt,
			},

			-- Optional: filetypes override
			filetypes = {
				lua = { "stylua" },
				svelte = { "prettierd", "prettier" },
				astro = { "prettierd", "prettier" },
				javascript = { "prettierd", "prettier", "eslint_d" },
				typescript = { "prettierd", "prettier", "eslint_d" },
				javascriptreact = { "prettierd", "prettier", "eslint_d" },
				typescriptreact = { "prettierd", "prettier", "eslint_d" },
				json = { "prettierd", "prettier" },
				graphql = { "prettierd", "prettier" },
				markdown = { "prettierd", "prettier", "markdownlint" },
				html = { "htmlbeautifier" },
				erb = { "htmlbeautifier" },
				css = { "prettierd", "prettier" },
				scss = { "prettierd", "prettier" },
				yaml = { "yamlfix" },
				toml = { "taplo" },
				xml = { "xmllint" },
				sh = { "shellcheck", "beautysh" },
				bash = { "beautysh" },
				go = { "gofmt" },
				proto = { "buf" },
				java = { "google-java-format", "checkstyle" },
				ruby = { "standardrb" },
				php = { "pint", "phpstan" },
				blade = { "blade-formatter" },
				dockerfile = { "hadolint" },
				terraform = { "tflint" },
			},

			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({ async = false })
						end,
					})
				end

				vim.lsp.buf.format({ timeout_ms = 2000 })
				-- Manual formatting
				vim.keymap.set("n", "<leader>cf", function()
					vim.lsp.buf.format({ async = true })
				end, { buffer = bufnr })
			end,
		})
	end,
}
