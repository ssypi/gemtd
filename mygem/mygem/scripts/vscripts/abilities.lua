local qualities = {
    "chipped",
    "flawed",
    "normal",
    "flawless",
    "perfect"
    -- TODO: "great"
}

function UpgradeQuality(keys)
    local caster = keys.caster
    local playerId = keys.caster:GetPlayerID()
    local player = PlayerResource:GetPlayer(playerId)
    print("upg qual")
    print(player)
    print(player.upgradeQuality)
    if player.upgradeQuality ~= nil then
        player.upgradeQuality = player.upgradeQuality + 1
    else
        player.upgradeQuality = 2
    end
    print(player.upgradeQuality)
    local ability = keys.ability
    if ability:GetLevel() < 5 then
        ability:SetLevel(ability:GetLevel() + 1)
    else
        ability:SetHidden(true)
        caster:RemoveAbility(ability:GetAbilityName())
    end
end



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

-- Combine two same gems into a better quality gem of the same type
function GemCombine(keys)
    local gem = keys.caster
    local player = gem.owner
    gem.keep = true
    print("Combining gem " .. gem:GetUnitName())
    local unitName = gem:GetUnitName()
    local gemName = string.find(gem:GetUnitName(), "gem_building_(.+)_(.+)")
--    print(unitName:find("gem_building_(.+)_(.+)"))
    print(unitName:match("gem_building_(.+)_(.+)"))
    local quality, type = unitName:match("gem_building_(.+)_(.+)")
    local qualityNum = FindTableKey(qualities, quality)
    local newName = "gem_building_" .. qualities[qualityNum+1] .. "_" .. type
    local pos = gem:GetAbsOrigin()
    local newGem = Gem:CreateGem(newName, pos, player)
    newGem.keep = true
    player.done = true

    UTIL_Remove(gem)
end

-- Combine gems into a special recipe gem
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
    combinedFrom[gem:GetUnitName()] = nil -- Remove the current gem from the recipe since we already used it

    print("Combining to " .. combinesTo)
    RemoveCombinedGems(player, combinedFrom)
    UTIL_Remove(gem)
    local newGem = CreateUnitByName(combinesTo, pos, false, player, player, team)
end

-- Remove all the gems used in a special combine
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