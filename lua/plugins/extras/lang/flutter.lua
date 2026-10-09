return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = "dart",
			root = { "pubspec.yaml" },
		})
	end,
	{ import = "lazyvim.plugins.extras.lang.json" },
	{
		"LazyVim/LazyVim",
		init = function()
			vim.filetype.add({
				extension = {
					arb = "json",
				},
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				dartls = {
					mason = false,
					keys = {
						{
							"<localleader>f",
							"",
							desc = "+flutter",
						},
						{
							"<localleader>fc",
							"<cmd>FlutterCommands<cr>",
							desc = "Open Command Palette",
						},
						{
							"<localleader>fr",
							function()
								local commands = require("flutter-tools.commands")
								if commands.is_running() then
									vim.cmd("FlutterReload")
								else
									vim.cmd("FlutterRun")
								end
							end,
							desc = "Run Project / Hot Reload",
						},
						{
							"<localleader>fR",
							"<cmd>FlutterRestart<cr>",
							desc = "Hot Restart",
						},
						{
							"<localleader>fq",
							"<cmd>FlutterQuit<cr>",
							desc = "Terminate Session",
						},
						{
							"<localleader>fd",
							"<cmd>FlutterDevices<cr>",
							desc = "Select Target Device",
						},
						{
							"<localleader>fe",
							"<cmd>FlutterEmulators<cr>",
							desc = "Select Emulator",
						},
						{
							"<localleader>fv",
							"<cmd>FlutterVisualDebug<cr>",
							desc = "Toggle Visual Debug Layout",
						},
						{
							"<localleader>fi",
							"<cmd>FlutterInspectWidget<cr>",
							desc = "Toggle Widget Inspector",
						},
						{
							"<localleader>fp",
							"<cmd>FlutterCopyProfilerUrl<cr>",
							desc = "Copy Profiler URL",
						},
						{
							"<localleader>fo",
							"<cmd>FlutterOutlineToggle<cr>",
							desc = "Toggle Widget Outline Tree",
						},
						{
							"<localleader>fl",
							"<cmd>FlutterLogToggle<cr>",
							desc = "Toggle Output Log Buffer",
						},
						{
							"<localleader>fL",
							"<cmd>FlutterLogClear<cr>",
							desc = "Clear Output Log Buffer",
						},
						{
							"<localleader>fg",
							"<cmd>FlutterPubGet<cr>",
							desc = "Run Pub Get",
						},
						{
							"<localleader>fG",
							"<cmd>FlutterPubUpgrade<cr>",
							desc = "Run Pub Upgrade",
						},
					},
				},
				jsonls = {
					settings = {
						json = {
							schemas = {
								{
									name = "arb.json",
									description = "Application Resource Bundle",
									fileMatch = { "*.arb" },
									url = "https://raw.githubusercontent.com/google/app-resource-bundle/main/schema/arb.json",
								},
							},
						},
					},
				},
			},
			setup = {
				dartls = function()
					return true
				end,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "dart" } },
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters = {
				prettier = {
					options = {
						ext_parsers = {
							arb = "json",
						},
					},
				},
			},
		},
	},
	{
		"akinsho/flutter-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			ui = { border = "rounded" },
			decorations = {
				statusline = {
					app_version = true,
					device = true,
				},
			},
			debugger = { enabled = true },
			fvm = true,
			closing_tags = { highlight = "LspInlayHint" },
			dev_log = { enabled = false },
			on_attach = require("lazyvim.plugins.lsp.keymaps").on_attach,
			capabilities = function(config)
				local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
				local has_blink, blink = pcall(require, "blink.cmp")

				return vim.tbl_deep_extend(
					"force",
					{},
					config,
					has_cmp and cmp_nvim_lsp.default_capabilities() or {},
					has_blink and blink.get_lsp_capabilities() or {}
				)
			end,
		},
		ft = "dart",
	},
}
