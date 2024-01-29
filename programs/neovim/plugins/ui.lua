local ignore_filetypes = {
	"help",
	"alpha",
	"dashboard",
	"neo-tree",
	"Trouble",
	"trouble",
	"lazy",
	"mason",
	"notify",
	"toggleterm",
	"lazyterm",
}

return {
	{
		"stevearc/dressing.nvim",
		lazy = true,
		opts = {
			select = {
				backend = {
					"telescope",
					"nui",
					"builtin",
				},
			},
		},
		init = function()
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.select = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.select(...)
			end
			---@diagnostic disable-next-line: duplicate-set-field
			vim.ui.input = function(...)
				require("lazy").load({ plugins = { "dressing.nvim" } })
				return vim.ui.input(...)
			end
		end,
	},
	{
		"lewis6991/hover.nvim",
		opts = {
			preview_opts = { border = nil },
			title = true,
      focusable = true,
		},
		config = function(_, opts)
			local hover = require("hover")

			hover.setup(vim.tbl_extend("force", opts, {
				init = function()
					require("hover.providers.lsp")
				end,
			}))
		end,
	},
	{
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = function()
			return {
				options = {
					theme = "auto",
					globalstatus = true,
				},
				sections = {
					lualine_c = { "filename" },
				},
				-- winbar = {
				-- 	lualine_c = { "filename" },
				-- },
				tabline = {
					lualine_a = { "tabs" },
					lualine_b = { "%F" },
					lualine_x = { "searchcount" },
					lualine_z = { "windows" },
				},
			}
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "VeryLazy",
		opts = {
			indent = {
				char = "│",
				tab_char = "│",
			},
			scope = { enabled = true },
			exclude = {
				filetypes = ignore_filetypes,
			},
		},
		main = "ibl",
	},
	{
		"echasnovski/mini.indentscope",
		version = false, -- wait till new 0.7.0 release to put it back on semver
		event = "VeryLazy",
		opts = {
			-- symbol = "▏",
			symbol = "│",
			options = { try_as_border = true },
		},
		init = function()
			vim.api.nvim_create_autocmd("FileType", {
				pattern = ignore_filetypes,
				callback = function()
					vim.b.miniindentscope_disable = true
				end,
			})
		end,
	},
	{ "nvim-tree/nvim-web-devicons", lazy = true },
	{
		"nvimdev/dashboard-nvim",
		event = "VimEnter",
		config = function()
			require("dashboard").setup({})
		end,
		dependencies = { { "nvim-tree/nvim-web-devicons" } },
	},
}
