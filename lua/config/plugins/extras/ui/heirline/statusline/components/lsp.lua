local lsp = {
	{
		init = function(self)
			self.error_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
			self.warning_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
			self.information_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.INFO })
			self.hint_count = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.HINT })
		end,
		{
			provider = function(self)
				return "  " .. self.error_count
			end,
			hl = "DiagnosticError",
			condition = function(self)
				return self.error_count ~= 0
			end,
		},
		{
			provider = function(self)
				return "  " .. self.warning_count
			end,
			hl = "DiagnosticWarn",
			condition = function(self)
				return self.warning_count ~= 0
			end,
		},
		{
			provider = function(self)
				return "  " .. self.information_count
			end,
			hl = "DiagnosticInfo",
			condition = function(self)
				return self.information_count ~= 0
			end,
		},
		{
			provider = function(self)
				return " 󰌵 " .. self.hint_count
			end,
			hl = "DiagnosticHint",
			condition = function(self)
				return self.hint_count ~= 0
			end,
		},
		on_click = {
			callback = function()
				Snacks.picker.diagnostics()
			end,
			name = "heirline_diagnostics_callback",
		},
		condition = function()
			return #vim.diagnostic.get(0) ~= 0
		end,
		update = { "DiagnosticChanged", "BufEnter" },
	},
	{
		flexible = 70,
		{
			provider = function()
				return "   "
					.. vim
						.iter(vim.lsp.get_clients({ bufnr = 0 }))
						:map(function(client)
							return client.name
						end)
						:filter(function(name)
							return name ~= "copilot"
						end)
						:join(" ")
			end,
			on_click = {
				callback = function()
					vim.schedule(function()
						vim.cmd("checkhealth vim.lsp")
					end)
				end,
				name = "heirline_lsp_callback",
			},
			condition = function()
				return #vim
					.iter(vim.lsp.get_clients({ bufnr = 0 }))
					:filter(function(client)
						return client.name ~= "copilot"
					end)
					:totable() ~= 0
			end,
			update = { "LspAttach", "LspDetach", "BufEnter" },
		},
		{ provider = "" },
	},
}

return lsp
