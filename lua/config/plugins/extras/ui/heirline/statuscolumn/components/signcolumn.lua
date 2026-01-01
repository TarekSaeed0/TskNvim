local signcolumn = {
	init = function(self)
		local extmarks = vim.api.nvim_buf_get_extmarks(
			0,
			-1,
			{ vim.v.lnum - 1, 0 },
			{ vim.v.lnum - 1, -1 },
			{ details = true, type = "sign" }
		)

		self.sign = nil
		for _, extmark in pairs(extmarks) do
			local sign = extmark[4]
			if
				sign
				and sign.sign_text
				and not sign.sign_hl_group:match("^Dap")
				and (not self.sign or (self.sign.priority < sign.priority))
			then
				self.sign = sign
			end
		end
	end,
	provider = function(self)
		return self.sign and self.sign.sign_text or "  "
	end,
	hl = function(self)
		return self.sign and { fg = vim.api.nvim_get_hl(0, { name = self.sign.sign_hl_group }).fg }
	end,
	condition = function(self)
		return self.signcolumn
	end,
}

return signcolumn
