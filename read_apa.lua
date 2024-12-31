local utils = require("ps2fs.utils")
local apa = require("ps2fs.apa")
local dev = io.open(arg[1], "rb")
print("header size", apa.header:packsize()+(apa.sub:packsize()*apa.maxsub))
while true do
--for i=1, 5 do
	local part = apa.read_header(dev)
	if part.magic ~= apa.magic then print("invalid magic ("..part.magic..")") break end
	local ptype = string.format("unknown [%.4x]", part.type)
	for k, v in pairs(apa.type) do
		if v == part.type then
			ptype = k
		end
	end
	print(string.format("%s (%s): %1.fMiB main: %d number: %d", part.id:gsub("\0+$", ""), ptype, (part.length*512)/(1024*1024), part.main, part.number))
	if part.next == 0 then break end
	dev:seek("set", part.next*512)
end