Silver = {
    radius = {250, 250, 250}
}

Knight = Silver

local ABILITY_SLOW = "sapphire_slow"

function Silver:OnCreated(keys)
    local quality = 1
    if vlua.find(self:GetUnitName(), "sterling") ~= nil then
        quality = 2
    elseif vlua.find(self:GetUnitName(), "knight") ~= nil then
        quality = 3
    end
    self.qualityNum = quality
    print(quality)
end

function Silver:OnAttackStart(keys)
end

function Silver:OnAttackLanded(keys)
    local target = keys.target
    print("Target: " .. target:GetEntityIndex())
    local gem = self
    local radius = Silver.radius[self.qualityNum]

    local unitsInFullRadius = FindUnitsInRadius(target:GetTeam(), target:GetOrigin(), nil, radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
    for _, unit in pairs(unitsInFullRadius) do
        unit:AddAbility(ABILITY_SLOW)
        local ability = unit:FindAbilityByName(ABILITY_SLOW)
        ability:SetLevel(1)
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
end
