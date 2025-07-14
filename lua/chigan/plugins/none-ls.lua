return {
	"nvimtools/none-ls.nvim",
	enabled = false,
	event = { "BufReadPre", "BufNewFile" },
	dependencies = { "williamboman/mason.nvim" },
	config = function()
		local null_ls = require("null-ls")
		local root_pattern = require("null-ls.utils").root_pattern

		null_ls.setup({
			root_dir = root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
			sources = {
				null_ls.builtins.diagnostics.eslint,
				null_ls.builtins.diagnostics.pint,
				null_ls.builtins.formatting.stylua,
				null_ls.builtins.formatting.shfmt,
				null_ls.builtins.formatting.blade_formatter,
				null_ls.builtins.formatting.prettierd,
				null_ls.builtins.code_actions.gomodifytags,
				null_ls.builtins.code_actions.impl,
				null_ls.builtins.formatting.goimports,
				null_ls.builtins.formatting.gofumpt,
			},
		})

		-- Auto format before save
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				vim.lsp.buf.format({
					bufnr = args.buf,
					timeout_ms = 5000,
					filter = function(client)
						return client.name == "null-ls"
					end,
				})
			end,
		})

		-- Register formatter manually like LazyVim does (without LazyVim)
		local function register_null_ls_formatter()
			local format = function(buf)
				vim.lsp.buf.format({
					bufnr = buf,
					filter = function(client)
						return client.name == "null-ls"
					end,
				})
			end

			local sources = function(buf)
				local available = require("null-ls.sources").get_available(vim.bo[buf].filetype, "NULL_LS_FORMATTING")
					or {}
				return vim.tbl_map(function(source)
					return source.name
				end, available)
			end

			-- You can use this table in your UI/plugin/command if needed:
			_G.NullLsFormatter = {
				name = "none-ls.nvim",
				priority = 200,
				primary = true,
				format = format,
				sources = sources,
			}
		end

		-- Simulate LazyVim.on_very_lazy (register after VimEnter)
		vim.api.nvim_create_autocmd("VimEnter", {
			once = true,
			callback = register_null_ls_formatter,
		})
	end,
}
