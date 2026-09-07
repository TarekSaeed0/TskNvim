return {
	{
		"neovim/nvim-lspconfig",
		init = function()
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(args)
					local bufnr = args.buf
					if not vim.api.nvim_buf_is_valid(bufnr) then
						return
					end

					vim.lsp.document_color.enable(true, { bufnr = bufnr }, { style = "virtual" })
				end,
			})
		end,
		opts = {
			diagnostics = {
				virtual_text = false,
				virtual_lines = true,
				float = { border = "rounded" },
			},
			format = { timeout_ms = 60000 },
			servers = {
				rust_analyzer = { mason = false },
			},
		},
	},
}
