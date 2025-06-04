return os.execute("git init") == 0
	and os.execute("git -C docs submodule add https://github.com/jothepro/doxygen-awesome-css.git") == 0
	and os.execute("cmake -S . -B build -DUNIT_TESTING=1") == 0
