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
--    PrintTable(keys)

--    local count = keys.caster:GetModifierCount()
--    for i=0, count do
--        print(keys.caster:GetModifierNameByIndex(i))
--    end

    local gem = keys.caster
    if gem:HasModifier("modifier_invulnerable") then
        gem:RemoveModifierByName("modifier_invulnerable")
    end

    if gem:HasModifier("modifier_tower_truesight_aura") then
        gem:RemoveModifierByName("modifier_tower_truesight_aura")
    end

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

function Upgrade(keys)
    local gem = keys.caster
    local upgradesTo = gem.upgradesTo
    print("Upgrading " .. gem:GetUnitName() .. " to " .. upgradesTo)
    local newGem = gem:ReplaceWith(upgradesTo)
    if newGem == nil then
        print("Error upgrading.")
        local hero = gem:GetPlayerOwner():GetAssignedHero()
        hero:ModifyGold(keys.ability:GetGoldCost(), false, DOTA_ModifyGold_Unspecified)
    end
end