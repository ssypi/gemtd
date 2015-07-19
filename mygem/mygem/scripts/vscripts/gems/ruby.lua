Ruby = {}

function Ruby:OnCreated(keys)
    self:SetRenderColor(250, 10, 10)
end

function Ruby:OnAttackLanded(keys)
    print("Ruby:OnAttackLanded")
    local target = keys.target
    print("Target: " .. target:GetEntityIndex())
    local gem = self
    local team = target:GetTeam()
    local pos = target:GetAbsOrigin()

    local unitsInFullRadius = {}

    assert(gem.halfRadius == nil or gem.fullRadius == nil or gem.halfRadius > gem.fullRadius)

    if gem.fullRadius ~= nil then
        unitsInFullRadius = FindUnitsInRadius(target:GetTeam(), target:GetOrigin(), nil, gem.fullRadius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        for _, unit in pairs(unitsInFullRadius) do
            if unit ~= target then
                print("Doing full damage(" .. keys.damage .. ") to " .. unit:GetEntityIndex())
                ApplyDamage({
                    victim = unit,
                    attacker = self,
                    damage = keys.damage,
                    damage_type = DAMAGE_TYPE_PHYSICAL
                })
            end
        end
    else
        print("No Full radius for " .. gem:GetUnitName())
    end

    if gem.halfRadius ~= nil then
        local unitsInHalfRadius = FindUnitsInRadius(team, pos, nil, gem.halfRadius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
        for _, unit in pairs(unitsInHalfRadius) do
            if unit ~= target and vlua.find(unitsInFullRadius, unit) == nil then
                print("Doing half damage(" .. keys.damage/2 .. ") to " .. unit:GetEntityIndex())
                ApplyDamage({
                    victim = unit,
                    attacker = self,
                    damage = keys.damage / 2,
                    damage_type = DAMAGE_TYPE_PHYSICAL
                })
            end
        end
    else
        print("No half-radius for " .. self:GetUnitName())
    end
end

function Ruby:OnAttackStart(keys)
end