if not ... then
  print("Usage: wc2.lua <file>")
  os.exit(1)
end

local f = assert(io.open(...))
local cnt = {}

while true do
	local l = f:read("l")
	if l == nil then break end

	for w in string.gmatch(l, "%w+") do
	  cnt[w] = (cnt[w] or 0) + 1
	end
end

for w, c in pairs(cnt) do
  print(w .. " --> " .. c)
end
