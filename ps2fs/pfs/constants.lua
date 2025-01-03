return function(pfs)
	pfs.blocksize = 0x2000
	pfs.magic = {
		super = "PFS\0",
		journal = "PFSL",
		segd = "SEGD",
		segi = "SEGI"
	}
	pfs.max_subparts = 64
	pfs.name_len = 255
	pfs.format_version = 3
	pfs.inode_max_blocks = 114

	pfs.attr = {
		read = 0x0001;
		write = 0x0002;
		exec = 0x0004;
		copyprotect = 0x0008;
		-- 0x0010
		subdir = 0x0020;
		-- 0x0040
		closed = 0x0080;
		-- 0x0100
		-- 0x0200
		-- 0x0400
		pda = 0x0800;
		psx = 0x1000;
		-- 0x2000
		hidden = 0x4000;
	}
	pfs.cache_flag = {
		dirty = 0x01;
		noload = 0x02;
		maskstatus = 0x0f;

		nothing = 0x00;
		segd = 0x10;
		segi = 0x20;
		bitmap = 0x40;
		masktype = 0xf0;
	}
	pfs.fsck_stat = {
		ok = 0x00;
		write_error = 0x01;
		errors_fixed = 0x02;
	}
	pfs.mode_flag = {
		set = 0x00;
		remove = 0x01;
		check = 0x02;
	}
	pfs.uid = 0xFFFF;
	pfs.gid = 0xFFFF;
end