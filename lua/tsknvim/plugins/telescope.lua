return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				enabled = vim.fn.executable("make") or vim.fn.executable("cmake"),
				config = function()
					require("telescope").load_extension("fzf")
				end,
				build = vim.fn.executable("make") and "make"
					or "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release",
			},
			"nvim-telescope/telescope-symbols.nvim",
		},
		opts = {
			defaults = {
				layout_strategy = "fit",
				layout_config = { preview_cutoff = 0 },
				results_title = false,
			},
			pickers = {
				find_files = { prompt_title = "Files" },
				grep_string = { prompt_title = "Search" },
				live_grep = { prompt_title = "Search Live" },
				buffers = { prompt_title = "Buffers" },
				oldfiles = { prompt_title = "File History" },
				commands = { prompt_title = "Commands" },
				tags = { prompt_title = "Tags" },
				command_history = { prompt_title = "Command History" },
				search_history = { prompt_title = "Search History" },
				help_tags = { prompt_title = "Help" },
				man_pages = { prompt_title = "Manual", sections = { "ALL" } },
				marks = { prompt_title = "Marks" },
				colorscheme = { prompt_title = "Color Schemes" },
				quickfix = { prompt_title = "Quick Fixes" },
				quickfixhistory = { prompt_title = "Quick Fix History" },
				loclist = { prompt_title = "Location List" },
				jumplist = { prompt_title = "Jump List" },
				vim_options = { prompt_title = "Options" },
				registers = { prompt_title = "Registers" },
				autocommands = { prompt_title = "Automatic Commands" },
				spell_suggest = { prompt_title = "Spelling Suggestions" },
				keymaps = { prompt_title = "Key Mappings" },
				filetypes = { prompt_title = "File Types" },
				highlights = { prompt_title = "Highlights" },
				current_buffer_fuzzy_find = { prompt_title = "Current Buffer Search" },
				current_buffer_tags = { prompt_title = "Current Buffer Tags" },
				lsp_references = { prompt_title = "References" },
				lsp_incoming_calls = { prompt_title = "Incoming Calls" },
				lsp_outgoing_calls = { prompt_title = "Outgoing Calls" },
				lsp_document_symbols = { prompt_title = "Document Symbols" },
				lsp_workspace_symbols = { prompt_title = "Workspace Symbols" },
				lsp_dynamic_workspace_symbols = { prompt_title = "Dynamic Workspace Symbols" },
				diagnostics = { prompt_title = "Diagnostics" },
				lsp_implementations = { prompt_title = "Implementations" },
				lsp_definitions = { prompt_title = "Definitions" },
				lsp_type_definitions = { prompt_title = "Type Definitions" },
			},
		},
		config = function(_, opts)
			if require("tsknvim.utils").is_loaded("nvim-notify") then
				require("telescope").setup({ extensions = { notify = { prompt_title = "Notifications" } } })
				require("telescope").load_extension("notify")
			end

			if require("tsknvim.utils").is_loaded("project.nvim") then
				require("telescope").setup({ extensions = { projects = { prompt_title = "Project History" } } })
				require("telescope").load_extension("projects")
			end

			local layout_strategies = require("telescope.pickers.layout_strategies")
			layout_strategies.fit = function(picker, columns, lines, layout_config)
				layout_config = vim.F.if_nil(layout_config, require("telescope.config").values.layout_config)
				local flip_ratio = 2.2
				local ratio = columns / lines
				if ratio >= flip_ratio then
					return layout_strategies.horizontal(picker, columns, lines, layout_config.horizontal)
				else
					return layout_strategies.vertical(picker, columns, lines, layout_config.vertical)
				end
			end

			require("telescope").setup(opts)
		end,
		cmd = "Telescope",
		keys = {
			{
				"<leader>f",
				function()
					require("telescope.builtin").find_files()
				end,
				desc = "Files",
			},
			{
				"<leader>s",
				function()
					require("telescope.builtin").grep_string()
				end,
				desc = "Search",
			},
			{
				"<leader>sl",
				function()
					require("telescope.builtin").live_grep()
				end,
				desc = "Search Live",
			},
			{
				"<leader>b",
				function()
					require("telescope.builtin").buffers()
				end,
				desc = "Buffers",
			},
			{
				"<leader>fh",
				function()
					require("telescope.builtin").oldfiles()
				end,
				desc = "File History",
			},
			{
				"<leader>C",
				function()
					require("telescope.builtin").commands()
				end,
				desc = "Commands",
			},
			{
				"<leader>T",
				function()
					require("telescope.builtin").tags()
				end,
				desc = "Tags",
			},
			{
				"<leader>Ch",
				function()
					require("telescope.builtin").command_history()
				end,
				desc = "Command History",
			},
			{
				"<leader>sh",
				function()
					require("telescope.builtin").search_history()
				end,
				desc = "Search History",
			},
			{
				"<leader>h",
				function()
					require("telescope.builtin").help_tags()
				end,
				desc = "Help",
			},
			{
				"<leader>m",
				function()
					require("telescope.builtin").man_pages()
				end,
				desc = "Manual",
			},
			{
				"<leader>M",
				function()
					require("telescope.builtin").marks()
				end,
				desc = "Marks",
			},
			{
				"<leader>cs",
				function()
					require("telescope.builtin").colorscheme()
				end,
				desc = "Color Schemes",
			},
			{
				"<leader>qf",
				function()
					require("telescope.builtin").quickfix()
				end,
				desc = "Quick Fixes",
			},
			{
				"<leader>qfh",
				function()
					require("telescope.builtin").quickfixhistory()
				end,
				desc = "Quick Fix History",
			},
			{
				"<leader>ll",
				function()
					require("telescope.builtin").loclist()
				end,
				desc = "Location List",
			},
			{
				"<leader>jl",
				function()
					require("telescope.builtin").jumplist()
				end,
				desc = "Jump List",
			},
			{
				"<leader>O",
				function()
					require("telescope.builtin").vim_options()
				end,
				desc = "Options",
			},
			{
				"<leader>r",
				function()
					require("telescope.builtin").registers()
				end,
				desc = "Registers",
			},
			{
				"<leader>ac",
				function()
					require("telescope.builtin").autocommands()
				end,
				desc = "Automatic Commands",
			},
			{
				"<leader>ss",
				function()
					require("telescope.builtin").spell_suggest()
				end,
				desc = "Spelling Suggestions",
			},
			{
				"<leader>km",
				function()
					require("telescope.builtin").keymaps()
				end,
				desc = "Key Mappings",
			},
			{
				"<leader>ft",
				function()
					require("telescope.builtin").filetypes()
				end,
				desc = "File Types",
			},
			{
				"<leader>hl",
				function()
					require("telescope.builtin").highlights()
				end,
				desc = "Highlights",
			},
			{
				"<leader>cbs",
				function()
					require("telescope.builtin").current_buffer_fuzzy_find()
				end,
				desc = "Current Buffer Search",
			},
			{
				"<leader>cbt",
				function()
					require("telescope.builtin").current_buffer_tags()
				end,
				desc = "Current Buffer Tags",
			},
			{
				"<leader>R",
				function()
					require("telescope.builtin").lsp_references()
				end,
				desc = "References",
			},
			{
				"<leader>ic",
				function()
					require("telescope.builtin").lsp_incoming_calls()
				end,
				desc = "Incoming Calls",
			},
			{
				"<leader>oc",
				function()
					require("telescope.builtin").lsp_outgoing_calls()
				end,
				desc = "Outgoing Calls",
			},
			{
				"<leader>ds",
				function()
					require("telescope.builtin").lsp_document_symbols()
				end,
				desc = "Document Symbols",
			},
			{
				"<leader>ws",
				function()
					require("telescope.builtin").lsp_workspace_symbols()
				end,
				desc = "Workspace Symbols",
			},
			{
				"<leader>dws",
				function()
					require("telescope.builtin").lsp_dynamic_workspace_symbols()
				end,
				desc = "Dynamic Workspace Symbols",
			},
			{
				"<leader>d",
				function()
					require("telescope.builtin").diagnostics()
				end,
				desc = "Diagnostics",
			},
			{
				"<leader>i",
				function()
					require("telescope.builtin").lsp_implementations()
				end,
				desc = "Implementations",
			},
			{
				"<leader>D",
				function()
					require("telescope.builtin").lsp_definitions()
				end,
				desc = "Definitions",
			},
			{
				"<leader>td",
				function()
					require("telescope.builtin").lsp_type_definitions()
				end,
				desc = "Type Definitions",
			},
			{
				"<leader>n",
				function()
					require("telescope").extensions.notify.notify()
				end,
				desc = "Notifications",
			},
			{
				"<leader>ph",
				function()
					require("telescope").extensions.projects.projects()
				end,
				desc = "Project History",
			},
		},
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		init = function()
			if vim.fn.argc() == 1 then
				---@diagnostic disable-next-line: param-type-mismatch
				local stat = vim.loop.fs_stat(vim.fn.argv(0))
				if stat and stat.type == "directory" then
					---@diagnostic disable-next-line: param-type-mismatch
					vim.defer_fn(function()
						require("telescope").extensions.file_browser.file_browser({ cwd = vim.fn.argv(0) })
					end, 0)
				end
			end
		end,
		opts = function()
			local utils = require("telescope._extensions.file_browser.utils")
			local actions_state = require("telescope.actions.state")
			local Path = require("plenary.path")

			local function toggle_respect_gitignore(prompt_bufnr)
				local current_picker = actions_state.get_current_picker(prompt_bufnr)
				local finder = current_picker.finder

				if type(finder.respect_gitignore) == "boolean" then
					finder.respect_gitignore = not finder.respect_gitignore
				else
					if finder.files then
						---@diagnostic disable-next-line: inject-field
						finder.respect_gitignore.file_browser = not finder.respect_gitignore.file_browser
					else
						---@diagnostic disable-next-line: inject-field
						finder.respect_gitignore.folder_browser = not finder.respect_gitignore.folder_browser
					end
				end
				current_picker:refresh(finder, { reset_prompt = true, multi = current_picker._multi })
			end

			local function toggle_current_buffer_path(prompt_bufnr)
				local current_picker = actions_state.get_current_picker(prompt_bufnr)
				local finder = current_picker.finder
				local bufr_path = Path:new(vim.fn.expand("#:p"))
				local bufr_parent_path = bufr_path:parent():absolute()

				if finder.path ~= bufr_parent_path then
					finder.path = bufr_parent_path
					utils.selection_callback(current_picker, bufr_path:absolute())
				else
					finder.path = vim.loop.cwd()
				end
				utils.redraw_border_title(current_picker)
				current_picker:refresh(finder, {
					new_prefix = utils.relative_path_prefix(finder),
					reset_prompt = true,
					multi = current_picker._multi,
				})
			end

			return {
				prompt_title = "File browser",
				mappings = {
					i = {
						["<C-h>h"] = toggle_respect_gitignore,
						["<C-e>"] = toggle_current_buffer_path,
					},
					n = { hh = toggle_respect_gitignore },
				},
				dir_icon = "",
				dir_icon_hl = "DevIconDefault",
			}
		end,
		config = function(_, opts)
			require("telescope").setup({ extensions = { file_browser = opts } })
			require("telescope").load_extension("file_browser")
		end,
		keys = {
			{
				"<leader>fb",
				function()
					require("telescope").extensions.file_browser.file_browser()
				end,
				desc = "File Browser",
			},
		},
	},
	{
		"debugloop/telescope-undo.nvim",
		dependencies = { "nvim-telescope/telescope.nvim" },
		opts = { prompt_title = "Undo" },
		config = function(_, opts)
			require("telescope").setup({ extensions = { undo = opts } })
			require("telescope").load_extension("undo")
		end,
		keys = {
			{
				"<leader>u",
				function()
					require("telescope").extensions.undo.undo()
				end,
				desc = "Undo",
			},
		},
	},
}
