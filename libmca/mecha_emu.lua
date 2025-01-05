local keys = "<c8c16c8c16c8c8c16c16"

local emu = {}
local _emu = {}

function emu:load_keys(file)
	local h = assert(io.open(file, "rb"))
	local dat = h:read("*a")
	h:close()
	self.cardkey_material_1, self.cardkey_hashkey_1, self.cardkey_material_2,
	self.cardkey_hashkey_2, self.challenge_material, self.kbit_material,
	self.kc_material, self.kbit_master_key, self.kc_master_key = keys:unpack(dat)
	self:reset_crypto_context()
end

function emu:reset_crypto_context()
	self.ctx = {

	}
end

function emu:calc_unique_key()

end

function emu:generate_challenge(chal1, chal2, chal3)

end

function emu:verify_response(response1, response2, response3)

end

function emu:get_content_key_offset(header)

end

function emu:decrypt_disk_key(header)

end

function emu:encrypt_card_key(key)

end

return emu