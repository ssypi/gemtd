Star = {
    burn = {
        radius = {300, 500, 700 },
        damage = {40, 50, 100}
    }
}

--[[
--  star ruby 40 damage in 265 range per second aura
--  blood star 50 damage per second in 500 range aura
--  firestar 65 dmg attack every 0.5s in 600 range
--     400 aoe??
 ]]

--local ABILITY_AURA = "star_aura"
local ABILITY_AURA = "aura_burn"

function Star:OnCreated(keys)
    local quality = 1
    if vlua.find(self:GetUnitName(), "blood") ~= nil then
        quality = 2
    elseif vlua.find(self:GetUnitName(), "fire") ~= nil then
        quality = 3
    end
    self.qualityNum = quality

    if quality <= 2 then
        self:AddAbility(ABILITY_AURA)
        local ability = self:FindAbilityByName(ABILITY_AURA)
        ability:SetLevel(self.qualityNum)
    end
end

function Star:OnAttackStart(keys)
    if self.qualityNum ~= 3 then
        print("Star ruby attack? wat.")
        return -- Only fire star has auto-attacks, others have aura
    end
    local target = keys.target
    local range = self:GetAttackRange()
    local units = FindUnitsInRadius(target:GetTeam(), self:GetOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)

    local count = 0
    local maxTargets = 10

    for _, unit in pairs(units) do
        if unit ~= target then
            self:PerformAttack(unit, false, false, true, false)
            count = count + 1
            if count >= maxTargets then
                break
            end
        end
    end
end

function Star:OnAttackLanded(keys)
end
