local module = {}

function module.ordered_table(t)
	local current_index = 1
	local metatable = {}
	function metatable:__newindex(key, value)
		rawset(self, key, value)
		rawset(self, current_index, key)
		current_index = current_index + 1
	end
	return setmetatable(t or {}, metatable)
end

function module.ordered_pairs(t)
	local current_index = 0
	local function iter(t)
		current_index = current_index + 1
		local key = t[current_index]
		if key then
			return key, t[key]
		end
	end
	return iter, t
end

return module
