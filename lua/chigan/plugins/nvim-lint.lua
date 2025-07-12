return {
	"mfussenegger/nvim-lint",
	event = {
		"BufReadPre",
		"BufNewFile",
	},
	config = function()
		local lint = require("lint")

		lint.linters = {
			eslint_d = {
				name = "eslint_d",
				parser = {},
				cmd = "eslint_d",
				args = {
					"--no-warn-ignored", -- <-- this is the key argument
					"--format",
					"json",
					"--stdin",
					"--stdin-filename",
					function()
						return vim.api.nvim_buf_get_name(0)
					end,
				},
			},
		}

		lint.linters_by_ft = {
			dockerfile = { "hadolint" },
			markdown = { "markdownlint-cli2" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			terraform = { "tflint" },
			php = { "tlint" },
			blade = { "tlint" },
		}

		local eslint_d = require("lint.linters.eslint_d")
		eslint_d.args = vim.tbl_extend("force", {
			"--config",
			function()
				return vim.fn.getcwd() .. "/eslint.config.js"
			end,
		}, eslint_d.args)

		-- lint.linters = {}
		local augroup = vim.api.nvim_create_augroup("nvim_lint_autocmds", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		-- Manual lint trigger
		vim.keymap.set("n", "<leader>ll", function()
			lint.try_lint()
		end, { desc = "Trigger linting for current file" })
	end,
}
