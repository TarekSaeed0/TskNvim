return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = "java",
			root = {
				"build.gradle",
				"build.gradle.kts",
				"build.xml", -- Ant
				"pom.xml", -- Maven
				"settings.gradle", -- Gradle
				"settings.gradle.kts", -- Gradle
			},
		})
	end,
	{ import = "lazyvim.plugins.extras.lang.java" },

	{
		"mfussenegger/nvim-jdtls",
		opts = {
			settings = {
				java = {
					format = {
						settings = {
							url = (function()
								local config_path = vim.env.XDG_CONFIG_HOME .. "/jdtls-format.xml"
								---@diagnostic disable-next-line: inject-field
								if vim.uv.fs_stat(config_path) then
									return config_path
								end
							end)(),
						},
					},
				},
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		dependencies = {
			"mason-org/mason.nvim",
			optional = true,
			opts = { ensure_installed = { "checkstyle" } },
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyLoad",
				callback = function(args)
					if args.data == "nvim-lint" then
						local checkstyle = require("lint").linters.checkstyle

						local config_file = vim.env.XDG_CONFIG_HOME .. "/checkstyle.xml"
						config_file = vim.uv.fs_stat(config_file) and config_file or "/sun_checks.xml"
						---@diagnostic disable-next-line: inject-field
						checkstyle.config_file = config_file

						return true
					end
				end,
			})
		end,
		opts = {
			linters_by_ft = {
				java = { "checkstyle" },
			},
		},
	},
}
