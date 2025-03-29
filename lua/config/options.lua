-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.tsknvim_performance = vim.fn.executable("termux-setup-storage") == 1

vim.g.lazyvim_check_order = false
vim.g.lazyvim_picker = "telescope"
vim.g.lazyvim_cmp = "nvim-cmp"

vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = false

vim.opt.cinkeys:remove({ "0#" })
vim.opt.cinoptions:append({ "#1s" })

vim.opt.pumblend = 0

vim.opt.winborder = "rounded"

vim.opt.fillchars:append({ foldopen = "", foldclose = "", msgsep = "─" })

vim.g.vimtex_syntax_conceal_disable = 1
vim.g.vimtex_compiler_progname = "nvr"
vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_format_enabled = 1
vim.g.vimtex_quickfix_enabled = 0
vim.g.vimtex_compiler_latexmk = {
	options = {
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
		"-shell-escape",
	},
}

vim.filetype.add({
	pattern = { ["${XDG_CONFIG_HOME}/hypr/.*%.conf"] = "hyprlang" },
})

require("config.usercmds")
