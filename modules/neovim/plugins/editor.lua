return {
  {
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		cmd = "Neotree",
		lazy = false,
		dependencies = {
      "nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
			"s1n7ax/nvim-window-picker",
		},
		opts = {
			filesystem = {
				filtered_items = {
					show_hidden_count = true,
					hide_dotfiles = false,
				},
			},
			window = {
				mappings = {
					["<CR>"] = "open_with_window_picker",
				},
			},
		},
		keys = {
			{ "<leader>ee", "<cmd>Neotree<CR>" },
			{ "<leader>er", "<cmd>Neotree reveal<CR>" },
		},
	},
  {
		"nvim-pack/nvim-spectre",
		build = false,
		cmd = "Spectre",
		opts = {
			open_cmd = "noswapfile vnew",
		},
		keys = {
			{ "<leader>sr", "<cmd>Spectre<CR>" },
			{ "<leader>sw", '<cmd>lua require("spectre").open_visual({select_word=true})<CR>' },
			{ "<leader>sp", '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>' },
		},
	},
  {
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		version = false,
		dependencies = {
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
			},
		},
		opts = {
			pickers = {
				find_files = {
					find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
				},
			},
		},
		keys = {
			-- find
			{ "<leader>ff", "<cmd>Telescope find_files<CR>" },
			{
				"<leader>fa",
				"<cmd>Telescope find_files find_command=rg,--files,--no-ignore,--hidden,--glob,!**/.git/*<CR>",
			},
			-- git
			{
				"<leader>gc",
				"<cmd>Telescope git_commits<CR>",
				desc = "commits",
			},
			{
				"<leader>gs",
				"<cmd>Telescope git_status<CR>",
				desc = "status",
			},
			-- search
			{ "<leader>fg", ":Telescope live_grep<CR>" },
			{ "<leader>fdd", ":Telescope diagnostics bufnr=0<CR>" },
			{ "<leader>fr", ":Telescope lsp_references<CR>" },
			{ "<leader>fi", ":Telescope lsp_implementations<CR>" },
			{ "<leader>fdt", ":Telescope lsp_type_definitions<CR>" },
			{ "<leader>fj", ":Telescope jumplist<CR>" },
			{ "<leader>fb", ":Telescope buffers<CR>" },
			{ "<leader>sc", ":Telescope command_history<CR>" },
			{ "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
			{
				"<leader>sm",
				"<cmd>Telescope marks<cr>",
				desc = "Jump to Mark",
			},
		},
	},
  {
		"axkirillov/easypick.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>fe", ":Easypick<CR>" },
		},
		opts = function()
			local easypick = require("easypick")
			local base_branch = "main"
			local pickers = {
				{
					name = "conflicts",
					command = "git diff --name-only --diff-filter=M --relative",
					previewer = easypick.previewers.file_diff(),
				},
				{
					name = "changed_files",
					command = "git diff --name-only $(git merge-base HEAD " .. base_branch .. " )",
					previewer = easypick.previewers.branch_diff({ base_branch = base_branch }),
				},
				{
					name = "diff",
					command = "git diff --name-only",
					previewer = easypick.previewers.default(),
				},
				{
					name = "tsc",
					command = 'npx tsc --noEmit | sed -n "/^[^ ]/p" | sed "s/(.*//" | uniq',
					previewer = easypick.previewers.default(),
				},
			}
			for k, v in ipairs(pickers) do
				v.name = k .. " " .. v.name
			end

			local opts = {
				pickers = pickers,
			}

			return opts
		end,
	},
  {
		"aznhe21/actions-preview.nvim",
		opts = function()
			local opts = {
				backend = { "telescope", "nui", "builtin" },
				telescope = vim.tbl_extend("force", require("telescope.themes").get_dropdown(), {
					layout_strategy = "vertical",
					layout_config = {
						prompt_position = "top",
					},
				}),
			}
			return opts
		end,
		config = function()
			vim.keymap.set({ "n" }, "<leader>dc", require("actions-preview").code_actions, { silent = false })
		end,
	},
  {
		"lewis6991/gitsigns.nvim",
		event = "VeryLazy",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "❚" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┇" },
			},
			linehl = true,
			current_line_blame = true,
			on_attach = function(buffer)
				local gs = package.loaded.gitsigns

				local function map(mode, l, r, desc)
					vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
				end

        -- stylua: ignore start
        map("n", "]h", gs.next_hunk, "Next Hunk")
        map("n", "[h", gs.prev_hunk, "Prev Hunk")
        map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
        map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
        map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
        map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
        map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
        map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
        map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
        map("n", "<leader>ghd", gs.diffthis, "Diff This")
        map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
        map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
			end,
		},
	},
  {
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
			},
			config = function(_, opts)
				local wk = require("which-key")
				wk.setup(opts)
				wk.register(opts.defaults)
			end,
		},
	},
  {
		"folke/trouble.nvim",
		cmd = { "TroubleToggle", "Trouble" },
		opts = { use_diagnostic_signs = true },
		keys = {},
	},
}
