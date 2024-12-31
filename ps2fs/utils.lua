local utils = {}

function utils.assert_die(cond, msg, ...)
	if not cond then
		io.stderr:write(string.format(msg, ...),"\n")
		os.exit(1)
	end
	return cond
end

return utils