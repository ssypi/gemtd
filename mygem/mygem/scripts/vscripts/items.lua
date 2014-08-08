function Build (keys)
    local caster = keys.caster
    local target = keys.target_points[1]
    --PrintMembers(keys)
    PrintTable(keys)
    local unit = CreateUnitByName("npc_mygem_building_rock", target, false, caster, caster, caster:GetTeamNumber())
    unit:SetControllableByPlayer(caster:GetPlayerID(), true)
    FindClearSpaceForUnit(unit, target, true)
end