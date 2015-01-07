Gold = {}

function Gold:OnCreated(keys)
    local quality = 1
    if vlua.find(self:GetUnitName(), "egyptian") ~= nil then
        quality = 2
    end
    self.qualityNum = quality

    --    self:AddAbility(ABILITY_SLOW)
    --    self:FindAbilityByName(ABILITY_SLOW):SetLevel(self.qualityNum)
end

function Gold:OnAttackStart(keys)
    local target = keys.target
    print("Target: " .. target:GetEntityIndex())
    local gem = self
end

function Gold:OnAttackLanded(keys)
end