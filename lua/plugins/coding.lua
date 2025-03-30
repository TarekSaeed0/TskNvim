return {
	{
		"saghen/blink.cmp",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- FIX: use vim.opt.winborder instead, when moree plugins support it
			completion = {
				menu = { border = "rounded" },
				documentation = { window = { border = "rounded" } },
			},
			signature = { window = { border = "rounded" } },
			cmdline = {
				enabled = true,
				completion = { menu = { auto_show = true } },
				---@diagnostic disable-next-line: assign-type-mismatch
				sources = function()
					local type = vim.fn.getcmdtype()
					-- Search forward and backward
					if type == "/" or type == "?" then
						return { "buffer" }
					end
					-- Commands
					if type == ":" or type == "@" then
						return { "cmdline" }
					end
					return {}
				end,
			},
		},
	},
}
