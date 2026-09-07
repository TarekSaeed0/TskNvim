-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.g.tsknvim_on_termux = vim.fn.executable("termux-setup-storage") == 1

-- disable some features for performance on termux
vim.g.tsknvim_performance = false

vim.g.lazyvim_check_order = false
vim.g.lazyvim_picker = "snacks"

vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

vim.opt.tabstop = 2
vim.opt.shiftwidth = 0
vim.opt.expandtab = false

vim.opt.cinkeys:remove({ "0#" })
vim.opt.cinoptions:append({ "#1s" })

vim.opt.pumblend = 0

vim.opt.winborder = "rounded"

vim.opt.fillchars:append({ foldopen = "", foldclose = "", msgsep = "─" })
vim.opt.listchars:append({ tab = "   " })

require("config.usercmds")
