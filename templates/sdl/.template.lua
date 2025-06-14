if os.execute("git init") ~= 0 then
	return false
end

if os.execute("cmake -S . -B build") ~= 0 then
	return false
end

return true
