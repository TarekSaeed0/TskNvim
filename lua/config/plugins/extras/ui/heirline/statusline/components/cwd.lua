local cwd = {
	{ provider = "  " },
	init = function(self)
		local path = vim.fn.fnamemodify(vim.fn.getcwd(), ":~"):gsub("%%", "%%%%")

		local separator = package.config:sub(1, 1)
		local ellipsis = "…"

		local components = vim.split(path, separator)

		local child = { flexible = 30 }

		child[1] = { provider = path }
		for i = 2, #components do
			child[i] = {
				provider = ellipsis .. separator .. table.concat(components, separator, i),
			}
		end
		child[#components + 1] = nil

		self[2] = self:new(child, 2)
	end,
	update = { "DirChanged", "VimResized" },
}

return cwd
