return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = "dart",
			root = { "pubspec.yaml" },
		})
	end,
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				dartls = {
					mason = false,
					keys = {
						{
							"<localleader>f",
							function()
								local commands = {}

								local flutter_tools_commands = require("flutter-tools.commands") ---@module "flutter-tools.commands"
								if flutter_tools_commands.is_running() then
									commands = {
										{
											id = "flutter-tools-hot-reload",
											label = "Hot reload",
											hint = "Reload a running flutter project",
											command = flutter_tools_commands.reload,
										},
										{
											id = "flutter-tools-hot-restart",
											label = "Hot restart",
											hint = "Restart a running flutter project",
											command = flutter_tools_commands.restart,
										},
										{
											id = "flutter-tools-visual-debug",
											label = "Visual Debug",
											hint = "Add the visual debugging overlay",
											command = flutter_tools_commands.visual_debug,
										},
										{
											id = "flutter-tools-performance-overlay",
											label = "Performance Overlay",
											hint = "Toggle performance overlay",
											command = flutter_tools_commands.performance_overlay,
										},
										{
											id = "flutter-tools-repaint-rainbow",
											label = "Repaint Rainbow",
											hint = "Toggle repaint rainbow",
											command = flutter_tools_commands.repaint_rainbow,
										},
										{
											id = "flutter-tools-slow-animations",
											label = "Slow Animations",
											hint = "Toggle slow animations",
											command = flutter_tools_commands.slow_animations,
										},
										{
											id = "flutter-tools-quit",
											label = "Quit",
											hint = "Quit running flutter project",
											command = flutter_tools_commands.quit,
										},
										{
											id = "flutter-tools-detach",
											label = "Detach",
											hint = "Quit running flutter project but leave the process running",
											command = flutter_tools_commands.detach,
										},
										{
											id = "flutter-tools-inspect-widget",
											label = "Inspect Widget",
											hint = "Toggle the widget inspector",
											command = flutter_tools_commands.inspect_widget,
										},
										{
											id = "flutter-tools-paint-baselines",
											label = "Paint Baselines",
											hint = "Toggle paint baselines",
											command = flutter_tools_commands.paint_baselines,
										},
									}
								else
									commands = {
										{
											id = "flutter-tools-run",
											label = "Run",
											hint = "Start a flutter project",
											command = flutter_tools_commands.run,
										},
									}
								end

								vim.list_extend(commands, {
									{
										id = "flutter-tools-pub-get",
										label = "Pub get",
										hint = "Run pub get in the project directory",
										command = flutter_tools_commands.pub_get,
									},
									{
										id = "flutter-tools-pub-upgrade",
										label = "Pub upgrade",
										hint = "Run pub upgrade in the project directory",
										command = flutter_tools_commands.pub_upgrade,
									},
									{
										id = "flutter-tools-list-devices",
										label = "List Devices",
										hint = "Show the available physical devices",
										command = require("flutter-tools.devices").list_devices,
									},
									{
										id = "flutter-tools-list-emulators",
										label = "List Emulators",
										hint = "Show the available emulator devices",
										command = require("flutter-tools.devices").list_emulators,
									},
									{
										id = "flutter-tools-open-outline",
										label = "Open Outline",
										hint = "Show the current files widget tree",
										command = require("flutter-tools.outline").open,
									},
									{
										id = "flutter-tools-generate",
										label = "Generate ",
										hint = "Generate code",
										command = flutter_tools_commands.generate,
									},
									{
										id = "flutter-tools-clear-dev-log",
										label = "Clear Dev Log",
										hint = "Clear previous logs in the output buffer",
										command = require("flutter-tools.log").clear,
									},
									{
										id = "flutter-tools-install-app",
										label = "Install app",
										hint = "Install a Flutter app on an attached device.",
										command = require("flutter-tools.commands").install,
									},
									{
										id = "flutter-tools-uninstall-app",
										label = "Uninstall app",
										hint = "Uninstall the app if already on the device.",
										command = require("flutter-tools.commands").uninstall,
									},
								})

								local flutter_tools_dev_tools = require("flutter-tools.dev_tools")
								if flutter_tools_dev_tools.is_running() then
									vim.list_extend(commands, {
										{
											id = "flutter-tools-copy-profiler-url",
											label = "Copy Profiler Url",
											hint = "Copy the profiler url to the clipboard",
											command = flutter_tools_commands.copy_profiler_url,
										},
										{
											id = "flutter-tools-open-dev-tools",
											label = "Open Dev Tools",
											hint = "Open flutter dev tools in the browser",
											command = flutter_tools_commands.open_dev_tools,
										},
									})
								else
									vim.list_extend(commands, {
										{
											id = "flutter-tools-start-dev-tools",
											label = "Start Dev Tools",
											hint = "Open flutter dev tools in the browser",
											command = require("flutter-tools.dev_tools").start,
										},
									})
								end

								local maximum_command_label_width = 0
								local maximum_command_hint_width = 0
								for _, command in ipairs(commands) do
									maximum_command_label_width = math.max(maximum_command_label_width, #command.label)
									maximum_command_hint_width = math.max(maximum_command_hint_width, #command.hint)
								end

								Snacks.picker({
									title = "Flutter Commands",
									finder = function()
										local items = {} ---@type snacks.picker.finder.Item[]
										for _, command in ipairs(commands) do
											---@diagnostic disable-next-line: missing-fields
											items[#items + 1] = {
												label = command.label,
												hint = command.hint,
												action = function()
													command.command()
												end,
											}
										end
										return items
									end,
									format = function(item)
										local ret = {} ---@type snacks.picker.Highlight[]

										ret[#ret + 1] = { Snacks.picker.util.align(item.label, maximum_command_label_width), "Type" }
										ret[#ret + 1] = { " - " }
										ret[#ret + 1] = { Snacks.picker.util.align(item.hint, maximum_command_hint_width), "Comment" }

										return ret
									end,
									layout = { preset = "vscode" },
									confirm = "item_action",
								})
							end,
							desc = "Flutter Commands",
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
		"akinsho/flutter-tools.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		opts = {
			ui = { border = "rounded" },
			decorations = {
				statusline = {
					app_version = true,
					device = true,
				},
			},
			closing_tags = { highlight = "LspInlayHint" },
			dev_log = { enabled = false },
			debugger = { enabled = true },
			lsp = {
				color = {
					enabled = true,
					virtual_text_str = "󱓻",
				},
			},
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
