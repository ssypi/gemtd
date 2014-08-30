Star = {
    burn = {
        radius = {300, 500, 700 },
        damage = {40, 50, 100}
    }
}

--local ABILITY_AURA = "star_aura"
local ABILITY_AURA = "aura_burn"

function Star:OnCreated(keys)
    local quality = 1
    if vlua.find(self:GetUnitName(), "fire") ~= nil then
        quality = 2
    elseif vlua.find(self:GetUnitName(), "blood") ~= nil then
        quality = 3
    end
    self.qualityNum = quality

    self:AddAbility(ABILITY_AURA)
    local ability = self:FindAbilityByName(ABILITY_AURA)
    ability:SetLevel(self.qualityNum)
end

function Star:OnAttackStart(keys)
    local target = keys.target
    print("Target: " .. target:GetEntityIndex())
    local gem = self
end

function Star:OnAttackLanded(keys)
end
