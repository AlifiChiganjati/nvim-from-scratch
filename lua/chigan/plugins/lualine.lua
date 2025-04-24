return {
	"nvim-lualine/lualine.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local lualine = require("lualine")
		local lazy_status = require("lazy.status")

		local colors = {
			blue = "#65D1FF",
			green = "#3EFFDC",
			violet = "#FF61EF",
			yellow = "#FFDA7B",
			red = "#FF4A4A",
			fg = "#c3ccdc",
			bg = "#112638",
			inactive_bg = "#2c3043",
			semilightgray = "#7f849c",
			gray = "#3b4252",
		}

		local my_lualine_theme = {
			normal = {
				a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
				y = { bg = colors.gray, fg = colors.fg }, -- tambahkan ini
			},
			insert = {
				a = { bg = colors.green, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
				y = { bg = colors.gray, fg = colors.fg },
			},
			visual = {
				a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
				y = { bg = colors.gray, fg = colors.fg },
			},
			command = {
				a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
				y = { bg = colors.gray, fg = colors.fg },
			},
			replace = {
				a = { bg = colors.red, fg = colors.bg, gui = "bold" },
				b = { bg = colors.bg, fg = colors.fg },
				c = { bg = colors.bg, fg = colors.fg },
				y = { bg = colors.gray, fg = colors.fg },
			},
			inactive = {
				a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
				b = { bg = colors.inactive_bg, fg = colors.semilightgray },
				c = { bg = colors.inactive_bg, fg = colors.semilightgray },
				y = { bg = colors.inactive_bg, fg = colors.semilightgray },
			},
		}
		-- Simpan tombol terakhir ditekan
		local last_key = ""

		-- Hook input tombol
		vim.on_key(function(key)
			if key ~= "" and key ~= "\r" then
				last_key = vim.fn.keytrans(key)
			end
		end, vim.api.nvim_create_namespace("last_key_logger"))

		-- Komponen untuk Lualine
		local function show_last_key()
			if last_key ~= "" then
				return "Key: " .. last_key
			end
			return ""
		end

		-- Fungsi untuk menampilkan indikator mode record
		local function record_indicator()
			local rec = vim.fn.reg_recording()
			if rec ~= "" then
				-- Misal, tampilkan "REC @q" jika sedang merekam register 'q'
				return "REC @" .. rec
			end
			return ""
		end

		-- Konfigurasi lualine
		lualine.setup({
			options = {
				theme = my_lualine_theme,
				globalstatus = true,
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "branch", "diff" },
				lualine_c = {
					{
						"diagnostics",
					},
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{ "filename" },
				},
				lualine_x = {
					{
						lazy_status.updates,
						cond = lazy_status.has_updates,
						color = { fg = "#ff9e64" },
					},
					{
						show_last_key,
						cond = function()
							return last_key ~= ""
						end,
						color = { fg = "#a0a8cd" },
					},
					{ record_indicator },
					{ "fileformat" },
				},
				lualine_y = {
					{ "progress", separator = " ", padding = { left = 1, right = 0 } },
					{ "location", padding = { left = 0, right = 1 } },
				},
				lualine_z = {
					function()
						return " " .. os.date("%R")
					end,
				},
			},
		})
	end,
}
