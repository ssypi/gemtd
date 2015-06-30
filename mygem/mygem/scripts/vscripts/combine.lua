-- http://lua-users.org/wiki/LuaCompilerInLua
-- compile the input file(s) passed as arguments and output them combined to stdout
local chunk = {}
for _, file in ipairs(arg) do
    chunk[#chunk + 1] = assert(loadfile(file))
end
if #chunk == 1 then
    chunk = chunk[1]
else
    -- combine multiple input files into a single chunk
    for i, func in ipairs(chunk) do
        chunk[i] = ("loadstring%q(...);"):format(string.dump(func))
    end
    chunk = assert(loadstring(table.concat(chunk)))
end
io.write(string.dump(chunk))