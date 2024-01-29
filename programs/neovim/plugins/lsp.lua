return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
			{ "folke/neodev.nvim", opts = {} },
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		opts = {
			diagnostics = {
				virtual_text = false,
			},
			servers = {
				tsserver = {},
			},
			setup = {
				["*"] = function()
					vim.keymap.set("n", "K", require("hover").hover)
					vim.keymap.set("n", "gK", require("hover").hover_select)
				end,
			},
		},
		config = function(_, opts)
			local servers = opts.servers
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities() or {},
				opts.capabilities or {},
				{
					dynamicRegistration = false,
					lineFoldingOnly = true,
				}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end

			local ensure_installed = {}
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
			end
		end,
	},
	{
		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		build = ":MasonUpdate",
		opts = {
			ensure_installed = {
				"cspell",
				"typescript-language-server",
				"stylua",
				"luacheck",
				--     "stylelint",
				-- "stylelint-lsp",
			},
		},
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end

			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
	{
		"nvimtools/none-ls.nvim",
		event = "VeryLazy",
		dependencies = { "mason.nvim" },
		opts = function(_, opts)
			local nls = require("null-ls")
			opts.root_dir = opts.root_dir
				or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
			opts.sources = vim.list_extend(opts.sources or {}, {
				nls.builtins.code_actions.eslint_d,
				nls.builtins.code_actions.cspell,
				nls.builtins.formatting.prettier,
				nls.builtins.formatting.stylua,
				nls.builtins.formatting.stylelint,
				nls.builtins.diagnostics.stylelint,
				nls.builtins.diagnostics.luacheck,
				nls.builtins.diagnostics.cspell.with({
					diagnostic_config = {
						virtual_text = false,
					},
					diagnostics_postprocess = function(diagnostics)
						diagnostics.severity = vim.diagnostic.severity["INFO"]
					end,
				}),
			})
			opts.diagnostics_format = "[#{c}] #{m} (#{s})"
		end,
	},
	{
		"ray-x/lsp_signature.nvim",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},
}
