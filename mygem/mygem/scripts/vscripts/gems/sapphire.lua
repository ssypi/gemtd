Sapphire = {
    slow = {
        duration = { 5, 5, 5, 6, 8, 100 },
        amount = { -20, -20, -20, -20, -20, -50 }
    }
}

local ABILITY_SLOW = "sapphire_slow"

function Sapphire:OnAttackLanded(keys)
    local target = keys.target
    local qualityNum = vlua.find(Gem.qualities, self.quality)
    target:AddAbility(ABILITY_SLOW)
    local ability = target:FindAbilityByName(ABILITY_SLOW)
    ability:SetLevel(qualityNum)
end

function Sapphire:OnAttackStart(keys)
end