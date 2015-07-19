Diamond = {}

local ABILITY_CRIT = "diamond_crit"

function Diamond:OnCreated(keys)
    print("Diamond created")
    self:AddAbility(ABILITY_CRIT)
    local ability = self:FindAbilityByName(ABILITY_CRIT)
    ability:SetLevel(self.qualityNum)
    self:SetRenderColor(220, 240, 240)
end

function Diamond:OnAttackLanded(keys)
    print("Damage: " .. keys.damage)
end

function Diamond:OnAttackStart(keys)
end