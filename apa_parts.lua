local apa = require("ps2fs.apa")
local utils = require("ps2fs.utils")
local devn = arg[1]
local dev = utils.assert_die(io.open(devn, "rb"))

for part, err in apa.partitions(dev) do
	utils.assert_die(part, err)
	local pname = part.id:gsub("\0+$", "")
	if part.main == 0 then
		print(pname)
	end
end
