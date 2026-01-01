local numbercolumn = {
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
				and sign.sign_hl_group:match("^Dap")
				and (not self.sign or (self.sign.priority < sign.priority))
			then
				self.sign = sign
			end
		end
	end,
	provider = function(self)
		if self.sign then
			return "%=" .. self.sign.sign_text
		elseif vim.opt.relativenumber:get() and vim.v.relnum ~= 0 then
			return "%=" .. tostring(vim.v.relnum) .. " "
		else
			return "%=" .. tostring(vim.v.lnum) .. " "
		end
	end,
	hl = function(self)
		return self.sign and { fg = vim.api.nvim_get_hl(0, { name = self.sign.sign_hl_group }).fg }
	end,
	on_click = {
		callback = function()
			if LazyVim.has("nvim-dap") then
				vim.cmd(tostring(vim.fn.getmousepos().line))

				require("dap").toggle_breakpoint()
			end
		end,
		name = "heirline_toggle_breakpoint",
	},
	condition = function()
		return vim.opt.number:get() or vim.opt.relativenumber:get()
	end,
}

return numbercolumn
