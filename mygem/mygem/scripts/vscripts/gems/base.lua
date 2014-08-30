function OnAttackLanded(keys)
    local gem = keys.attacker
    print(gem:GetUnitName() .. " attack landed")
    if gem.OnAttackLanded ~= nil then
        gem:OnAttackLanded(keys)
    end
end

-- TODO: this gets called before custom Gem functions/variables have been initialized which means OnCreated is always nil
-- TODO: maybe we should add the tower_scripts proxy ability only after creation in the init function instead of in KV
function OnCreated(keys)
    print("OnCreated")
    PrintTable(keys)
    if keys.caster.OnCreated ~= nil then
        keys.caster:OnCreated(keys)
    end
end

function OnAttackStart(keys)
    local gem = keys.attacker
    print("OnAttackStarted for " .. gem:GetUnitName())
    if gem.OnAttackStart ~= nil then
        gem:OnAttackStart(keys)
    end
end