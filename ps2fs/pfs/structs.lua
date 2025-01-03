return function(pfs)
	pfs.t = {}
	local function substruct(name)

	end
	pfs.t = {
		-- libpfs.h:87-96
		journal = "<c4HHc1016";
		journal_f = {
			"magic",
			"num",
			"checksum",
			"_log",
		};

		-- libpfs.h:99-104
		aentry = "<BBHc3";
		aentry_f = {
			"klen",
			"vlen",
			"alen",
			"str"
		};

		-- libpfs.h:107-113
		dentry = "<IBBHc504";
		dentry_f = {
			"inode",
			"sub",
			"plen",
			"alen",
			"path"
		};

		blockinfo = "<IHH";
		blockinfo_f = {
			"number",
			"subpart",
			"count"
		};

		superblock = "<c4IIIII"
	}
end