return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			root = {
				".clangd",
				".clang-tidy",
				".clang-format",
				"compile_commands.json",
				"compile_flags.txt",
				"configure.ac", -- AutoTools
			},
		})
	end,
	{ import = "lazyvim.plugins.extras.lang.clangd" },
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				clangd = { mason = false },
			},
		},
	},
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
			},
		},
	},
	{
		"mfussenegger/nvim-lint",
		opts = {
			linters_by_ft = {
				c = { "clangtidy" },
				cpp = { "clangtidy" },
			},
		},
	},
	{
		"Civitasv/cmake-tools.nvim",
		opts = {
			cmake_build_directory = "build",
			cmake_virtual_text_support = false,
			cmake_runner = {
				opts = { start_insert = true, focus = true },
			},
		},
		config = function(_, opts)
			require("cmake-tools").setup(opts)

			vim.keymap.set("n", "<localleader>c", "", { desc = "+cmake" })

			vim.keymap.set("n", "<localleader>cb", function()
				require("cmake-tools").build({})
			end, { desc = "Build target" })
			vim.keymap.set("n", "<localleader>cB", function()
				require("cmake-tools").build_current_file({})
			end, { desc = "Build current file target" })

			vim.keymap.set("n", "<localleader>cr", function()
				require("cmake-tools").run({})
			end, { desc = "Run target" })
			vim.keymap.set("n", "<localleader>cR", function()
				require("cmake-tools").run_current_file({})
			end, { desc = "Run current file target" })

			vim.keymap.set("n", "<localleader>cd", function()
				require("cmake-tools").debug({})
			end, { desc = "Debug target" })
			vim.keymap.set("n", "<localleader>cD", function()
				require("cmake-tools").debug_current_file({})
			end, { desc = "Debug current file target" })

			vim.keymap.set("n", "<localleader>ct", function()
				require("cmake-tools").run_test({})
			end, { desc = "Run test" })
		end,
	},
}
