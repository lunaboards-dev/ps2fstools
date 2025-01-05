local usb = require "moonusb"
local ctx = usb.init()

local usbio = {
	vid = 0x054c,
	pid = 0x02ea,
	struct = "<HBxc1024"
}
local dev = {}

function usbio.attach(vid, pid)
	local dev, devh = ctx:open(vid, pid)
	devh:reset_device()
	-- scan interfaces
	local cfg = devh:get_configuration()
	local iface
	for i=1, #cfg.interface do
		if cfg.interface[i].class == "vendor specific" then
			iface = devh:claim_interface(i)
		end
	end
end

function dev:bulk_write(buf)
	local ptr = usb.malloc(self.h, #buf)
	ptr:write(0, nil, buf)
	self.h:bulk_transfer(0x02, ptr, #buf, 500)
	ptr:free()
end

function dev:bulk_read(amt)
	local ptr = usb.malloc(self.h, amt)
	--ptr:write(0, nil, buf)
	self.h:bulk_transfer(0x02, ptr, amt, 500)
	local rtv = ptr:read()
	ptr:free()
	return rtv
end

function dev:read_page()

end