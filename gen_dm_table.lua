local utils = require("ps2fs.utils")
local apa = require("ps2fs.apa")
local devn = arg[1]
local part_name = arg[2]
local dev = utils.assert_die(io.open(devn, "rb"))

for part, err in apa.partitions(dev) do
	utils.assert_die(part, err)
	local pname = part.id:gsub("\0+$", "")
	if pname == part_name then
		local chunks = {
			{start=part.start+0x2000, length=part.length-0x2000}
		}
		for i=1, part.nsub do
			table.insert(chunks, {
				start = part.subs[i].start+2,
				length = part.subs[i].length-2
			})
		end
		print(string.format("# APA: %s/%s", devn, part_name))
		local pos = 0
		for i=1, #chunks do
			local c = chunks[i]
			print(string.format("%d %d linear %s %d", pos, c.length, devn, c.start))
			pos = pos + c.length
		end
	end
end