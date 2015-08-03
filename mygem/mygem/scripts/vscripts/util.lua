function IsValid(entity)
    local isValid = entity ~= nil and IsValidEntity(entity) and not IsMarkedForDeletion(entity) and not entity:IsNull()
    return isValid
end

function CopyFunctions(copyFrom, copyTo)
    for k, v in pairs(copyFrom) do
        if type(v) == "function" then
            if copyTo[k] == nil then
                copyTo[k] = v
            else
                print("Error: Trying to override a function! " .. k)
            end
        end
    end
end

function FindTableKey(table, value)
    for k,v in pairs(table) do
        if v == value then
            return k
        end
    end
end

function CopyTableShallow(t)
    local t2 = {}
    for k, v in pairs(t) do
        t2[k] = v
    end
    return t2
end

function PrintTable(t, indent, done)
    --print ( string.format ('PrintTable type %s', type(keys)) )
    if type(t) ~= "table" then return end
    done = done or {}
    done[t] = true
    indent = indent or 0
    local l = {}
    for k, v in pairs(t) do
        table.insert(l, k)
    end
    table.sort(l)
    for k, v in ipairs(l) do
        -- Ignore FDesc
        if v ~= 'FDesc' then
            local value = t[v]
            if type(value) == "table" and not done[value] then
                done[value] = true
                print(string.rep("\t", indent) .. tostring(v) .. ":")
                PrintTable(value, indent + 2, done)
            elseif type(value) == "userdata" and not done[value] then
                done[value] = true
                print(string.rep("\t", indent) .. tostring(v) .. ": " .. tostring(value))
                PrintTable((getmetatable(value) and getmetatable(value).__index) or getmetatable(value), indent + 2, done)
            else
                if t.FDesc and t.FDesc[v] then
                    print(string.rep("\t", indent) .. tostring(t.FDesc[v]))
                else
                    print(string.rep("\t", indent) .. tostring(v) .. ": " .. tostring(value))
                end
            end
        end
    end
end

function PrintMembers(data)
    if data then
        print(data)
        print("members:")
        for key, value in pairs(getmetatable(data)) do
            print("found member " .. key);
            print(value)
            if (type(value) == "table") then
                for key, value in pairs(value) do
                    print("found member " .. key);
                    print(value)
                end
            end
        end
    end
end