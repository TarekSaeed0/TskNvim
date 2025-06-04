return {
	recommended = function()
		return LazyVim.extras.wants({
			ft = "cmake",
			root = { "CMakePresets.json", "CTestConfig.cmake", "cmake" },
		})
	end,
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				neocmake = {},
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = { ensure_installed = { "cmake" } },
	},
	{
		"Civitasv/cmake-tools.nvim",
		lazy = true,
		init = function()
			local loaded = false
			local function check()
				local cwd = vim.uv.cwd()
				if vim.fn.filereadable(cwd .. "/CMakeLists.txt") == 1 then
					require("lazy").load({ plugins = { "cmake-tools.nvim" } })
					loaded = true
				end
			end
			check()
			vim.api.nvim_create_autocmd("DirChanged", {
				callback = function()
					if not loaded then
						check()
					end
				end,
			})
		end,
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
