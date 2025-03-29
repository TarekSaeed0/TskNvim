vim.fn.system({ "cmake", "-S", ".", "-B", "build", "-DUNIT_TESTING=1" })
