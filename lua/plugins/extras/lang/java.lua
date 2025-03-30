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
		"mfussenegger/nvim-lint",
		dependencies = {
			"williamboman/mason.nvim",
			optional = true,
			opts = { ensure_installed = { "checkstyle" } },
		},
		init = function()
			vim.api.nvim_create_autocmd("User", {
				pattern = "LazyLoad",
				callback = function(args)
					if args.data == "nvim-lint" then
						local checkstyle = require("lint").linters.checkstyle
						checkstyle.config_file = "/sun_checks.xml"
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
