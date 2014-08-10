local gems = {
    "gem_building_chipped_sapphire",
    "gem_building_chipped_ruby"
}

function Build (keys)
    local caster = keys.caster
    local player = caster:GetPlayerOwner()
    local target = keys.target_points[1]
    if player.gems == nil then
        player.gems = {}
    end
    --PrintMembers(keys)
    local gemNumber = RandomInt(1,2)
--    PrintTable(keys)
    local unit = CreateUnitByName("gem_dummy", target, true, caster, caster, caster:GetTeamNumber())
    if unit:GetOrigin() ~= target then
        print("no space")
        UTIL_Remove(unit)
        return
    else
        UTIL_Remove(unit)
        unit = CreateUnitByName(gems[gemNumber], target, false, caster, caster, caster:GetTeamNumber())
        unit:SetControllableByPlayer(caster:GetPlayerID(), true)
--    FindClearSpaceForUnit(unit, target, false)
        unit.owner = player
        table.insert(player.gems, unit)
        local item = keys.ability
        item:SetCurrentCharges(item:GetCurrentCharges() - 1)
    end
end