return {
	desc = "make Neovim's fold look modern and keep high performance.",
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				["*"] = {
					capabilities = {
						textDocument = {
							foldingRange = {
								dynamicRegistration = false,
								lineFoldingOnly = true,
							},
						},
					},
					keys = {
						{
							"K",
							function()
								if not LazyVim.is_loaded("nvim-ufo") or not require("ufo").peekFoldedLinesUnderCursor(false, false) then
									vim.lsp.buf.hover()
								end
							end,
						},
					},
				},
			},
		},
	},
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
			"nvim-treesitter/nvim-treesitter",
			"neovim/nvim-lspconfig",
		},
		event = { "BufReadPost", "BufNewFile" },
		---@type UfoConfig
		---@diagnostic disable-next-line: missing-fields
		opts = {
			open_fold_hl_timeout = 0,
			provider_selector = function()
				return { "treesitter", "indent" }
			end,
			enable_get_fold_virt_text = true,
			fold_virt_text_handler = function(virtText, _, endLnum, _, _, ctx)
				table.insert(virtText, { " … ", "UfoFoldedEllipsis" })
				local end_virtual_text = ctx.get_fold_virt_text(endLnum)
				for index, chunk in ipairs(end_virtual_text) do
					if not chunk[1]:match("^%s*$") then
						chunk[1] = chunk[1]:gsub("^%s*", "")
						vim.list_extend(virtText, end_virtual_text, index)
						break
					end
				end
				return virtText
			end,
			preview = {
				win_config = {
					border = { "", "─", "", "", "", "─", "", "" },
					winhighlight = "Normal:NormalFloat",
					winblend = 0,
				},
				mappings = {
					scrollU = "<C-u>",
					scrollD = "<C-d>",
					jumpTop = "[",
					jumpBot = "]",
				},
			},
		},
		---@param opts UfoConfig
		config = function(_, opts)
			require("ufo").setup(opts)

			vim.opt.foldlevel = 99
			vim.opt.foldlevelstart = 99
		end,
		keys = {
			{
				"zR",
				function()
					require("ufo").openAllFolds()
				end,
			},
			{
				"zM",
				function()
					require("ufo").closeAllFolds()
				end,
			},
		},
	},
}
