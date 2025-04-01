return {
	{
		"saghen/blink.cmp",
		event = "CmdlineEnter",
		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			enabled = function()
				return not vim.list_contains({ "DressingInput" }, vim.bo.filetype)
					and vim.bo.buftype ~= "prompt"
					and vim.b.completion ~= false
			end,
			-- FIX: use vim.opt.winborder instead, when more plugins support it
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
