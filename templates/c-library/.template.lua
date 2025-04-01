vim.fn.system({ "git", "init" })
vim.fn.system({ "git", "submodule", "add", "https://github.com/jothepro/doxygen-awesome-css.git" })

vim.fn.system({ "cmake", "-S", ".", "-B", "build", "-DUNIT_TESTING=1" })
