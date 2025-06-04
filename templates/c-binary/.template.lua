if os.execute("git init") ~= 0 then
	return false
end

if docs == "false" then
	remove_directory("docs")
	remove_directory(".github")
else
	if os.execute("git -C docs submodule add https://github.com/jothepro/doxygen-awesome-css.git") ~= 0 then
		return false
	end
end

if os.execute("cmake -S . -B build") ~= 0 then
	return false
end

return true
