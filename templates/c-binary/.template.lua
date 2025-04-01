return os.execute("git init") == 0
	and os.execute("git submodule add https://github.com/jothepro/doxygen-awesome-css.git") == 0
	and os.execute("cmake -S . -B build") == 0
