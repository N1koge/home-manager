return {
  { "nvim-lua/plenary.nvim", lazy = false },
  {
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function(_, opts)
			local Terminal = require("toggleterm.terminal").Terminal

			local sh = Terminal:new({
				cmd = "/bin/zsh",
				direction = "float",
				hiddne = true,
				on_open = function(term)
					vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", [[<C-\><C-n>]], opts)
					vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", opts)
				end,
			})
			vim.keymap.set("n", "<leader>sh", function()
				sh:toggle()
			end, opts)
		end,
	},
}
