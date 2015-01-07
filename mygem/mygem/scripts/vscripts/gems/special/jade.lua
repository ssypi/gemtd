Jade = {
}

local ABILITY_SLOW = "jade_slow"
local ABILITY_LUCKY = "jade_lucky"

function Jade:OnCreated(keys)
    local quality = 1
    if vlua.find(self:GetUnitName(), "lucky") ~= nil then
        quality = 3

    elseif vlua.find(self:GetUnitName(), "china") ~= nil then
        quality = 2
    end
    self.qualityNum = quality

--    self:AddAbility(ABILITY_SLOW)
--    self:FindAbilityByName(ABILITY_SLOW):SetLevel(self.qualityNum)

    self:AddAbility(ABILITY_LUCKY)
    self:FindAbilityByName(ABILITY_LUCKY):SetLevel(self.qualityNum)
end

function Jade:OnAttackStart(keys)
    local target = keys.target
    print("Target: " .. target:GetEntityIndex())
    local gem = self
end

function Jade:OnAttackLanded(keys)
end

function GiveGold(keys)
    print("GOLD")
    local owner = keys.caster:GetOwner()
    owner:ModifyGold(10, false, DOTA_ModifyGold_SellItem)
end