local apa = {}
apa.type = {
	free =     0x0000,
	mbr =      0x0001,
	ext2swap = 0x0082,
	ext2 =     0x0083,
	reiser =   0x0088,
	pfs =      0x0100,
	cfs =      0x0101,
	hdl =      0x1337
}
apa.idmax = 32
apa.maxsub = 64
apa.passmax = 8
apa.flag = {
	sub = 0x0001
}
apa.mbr_version = 2
apa.modver_major = 2
apa.modver_minor = 5
apa.modver = (apa.modver_major << 8) | apa.modver_minor
apa.magic = "APA\0"
apa.time = "<xBBBBBH"
apa.sub = "<II"
apa.mbr = "<c32IIc"..apa.time:packsize().."IIc200"
apa.header = "<Ic4IIc"..apa.idmax.."c"..apa.passmax.."c"..apa.passmax..
			"IIHHIc"..apa.time:packsize().."III"..string.rep("x", 7*4)..
			string.rep("x", 128).."c"..apa.mbr:packsize()
function apa.decode_time(time)
	local ct = {}
	ct.sec, ct.min, ct.hour, ct.day, ct.month, ct.year = apa.time:unpack(time)
	return ct
end

function apa.read_header(dev)
	local hdr = dev:read(apa.header:packsize())
	local part, created, mbr, subs = {}
	part.checksum, part.magic, part.next, part.prev, part.id, part.rpwd,
	part.fpwd, part.start, part.length, part.type, part.flags, part.nsub,
	created, part.main, part.number, part.modver, mbr = apa.header:unpack(hdr)
	
	part.created = apa.decode_time(created)
	
	local m = {}
	m.magic, m.version, m.nsector, created, m.osd_start, m.osd_size,
	m.padding = apa.mbr:unpack(mbr)
	m.created = apa.decode_time(created)
	part.mbr = m
	part.subs = {}
	for i=1, apa.maxsub do
		local sub = dev:read(apa.sub:packsize())
		local start, size = apa.sub:unpack(sub)
		if i <= part.nsub then
			part.subs[i] = {start = start, length = size}
		end
	end
	return part
end

function apa.partitions(dev)
	local nseek = 0
	return function()
		if nseek < 0 then return end
		dev:seek("set", nseek)
		local part = apa.read_header(dev)
		if part.magic ~= apa.magic then --[[print("invalid magic ("..part.magic..")")]] return false, "bad magic" end
		--[[local ptype = string.format("unknown [%.4x]", part.type)
		for k, v in pairs(apa.type) do
			if v == part.type then
				ptype = k
			end
		end
		print(string.format("%s (%s): %1.fMiB", part.id:gsub("\0+$", ""), ptype, (part.length*512)/(1024*1024)))]]
		nseek = part.next*512
		if part.next == 0 then nseek = -1 end
		return part
	end
end

return apa