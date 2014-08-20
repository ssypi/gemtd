function Test(keys)
    print("kalatest")
end

function GemKeep(keys)
    local gem = keys.caster
    local player = gem.owner
    gem.keep = true
    player.done = true
end

function GemDelete(keys)
    local gem = keys.caster
    RemoveRock(gem)
end

function GemCombine(keys)
    local gem = keys.caster
    local player = gem.owner
    gem.keep = true
    print("Combining gem " .. gem:GetUnitName())
end

function GemCombineSpecial(keys)
    local gem = keys.caster
    local player = gem.owner
    gem.keep = true
    print("Combine special for " .. gem:GetUnitName())

    local allGems = player.allGems
    local tableIndex = FindTableKey(allGems, gem)
    table.remove(allGems, tableIndex)
    local pos = gem:GetAbsOrigin()
    local team = gem:GetTeam()
    local combinesTo = gem.combinesTo
    local combinedFrom = MyGemGameMode.kv.units[combinesTo].CombinedFrom
    combinedFrom[gem:GetUnitName()] = nil

    print("Combining to " .. combinesTo)
    RemoveCombinedGems(player, combinedFrom)
    UTIL_Remove(gem)
    local newGem = CreateUnitByName(combinesTo, pos, false, player, player, team)
end

function RemoveCombinedGems(player, combinedFrom)
    local allGems = player.allGems
    for i=#allGems, 1, -1 do
        local gem = allGems[i]
        if combinedFrom[gem:GetUnitName()] then
            combinedFrom[gem:GetUnitName()] = 0 -- So we don't remove multiples of the same gem
            local pos = gem:GetAbsOrigin()
            local owner = gem.owner
            UTIL_Remove(gem)
            table.remove(allGems, i)
            CreateRock(pos, owner)
        end
    end
end