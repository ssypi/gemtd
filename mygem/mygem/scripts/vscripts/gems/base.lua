function OnAttackLanded(keys)
    local gem = keys.attacker
    print(gem:GetUnitName() .. " attack landed")
    if gem.OnAttackLanded ~= nil then
        gem:OnAttackLanded(keys)
    end
end

function OnAttackStart(keys)
    local gem = keys.attacker
    print("OnAttackStarted for " .. gem:GetUnitName())
    if gem.OnAttackStart ~= nil then
        gem:OnAttackStart(keys)
    end
end