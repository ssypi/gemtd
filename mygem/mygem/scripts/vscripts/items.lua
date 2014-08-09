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
    local unit = CreateUnitByName(gems[gemNumber], target, false, caster, caster, caster:GetTeamNumber())
    unit:SetControllableByPlayer(caster:GetPlayerID(), true)
    FindClearSpaceForUnit(unit, target, true)
    unit.owner = player
    table.insert(player.gems, unit)
end