---@type LazySpec[]
return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = { "kevinhwang91/promise-async" },
		---@type UfoConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			open_fold_hl_timeout = 0,
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
			fold_virt_text_handler = function(virtual_text, _, end_line, _, _, context)
				table.insert(virtual_text, { " … ", "UfoFoldedEllipsis" })
				local end_virtual_text = context.get_fold_virt_text(end_line)
				for index, chunk in ipairs(end_virtual_text) do
					if not chunk[1]:match("^%s*$") then
						chunk[1] = chunk[1]:gsub("^%s*", "")
						---@diagnostic disable-next-line: missing-parameter
						vim.list_extend(virtual_text, end_virtual_text, index)
						break
					end
				end
				return virtual_text
			end,
			enable_get_fold_virt_text = true,
			preview = { win_config = { winblend = 0, winhighlight = "Normal:NormalFloat" } },
		},
		---@param opts UfoConfig
		config = function(_, opts)
			require("ufo").setup(opts)

			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99

			vim.keymap.set("n", "K", function()
				if not require("ufo").peekFoldedLinesUnderCursor(false, false) then
					vim.cmd.Lspsaga("hover_doc")
				end
			end)
		end,
		event = { "BufReadPost", "BufNewFile" },
		cmd = {
			"UfoEnable",
			"UfoDisable",
			"UfoInspect",
			"UfoAttach",
			"UfoDetach",
			"UfoEnableFold",
			"UfoDisableFold",
		},
		keys = {
			"zf",
			"zF",
			"fo",
			"zd",
			"zD",
			"zE",
			"zo",
			"zO",
			"zc",
			"zC",
			"za",
			"zA",
			"zv",
			"zx",
			"zX",
			"zm",
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
			},
			"zr",
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
			},
			"foldo",
			"foldc",
			"zn",
			"zN",
			"zi",
			"[z",
			"]z",
			"zj",
			"zk",
			"foldd",
			"folddoc",
		},
	},
}
