Opal = {
    aura = {
        radius = {200, 300, 400, 500, 600, 1000},
        bonus = {20, 25, 30, 35, 50, 100}
    }
}

local ABILITY_AURA = "opal_aura"

function Opal:OnCreated(keys)
    print("Opal created")

    self:AddAbility(ABILITY_AURA)
    local ability = self:FindAbilityByName(ABILITY_AURA)
    ability:SetLevel(self.qualityNum)

    local dmg = self:GetBaseDamageMax()
    local dmgMin = self:GetBaseDamageMin()
    print(dmg)
    print(dmgMin)
    self:SetBaseDamageMax(dmg-0)
    self:SetBaseDamageMin(dmgMin-0)
    print(self:GetBaseDamageMax())
    print(self:GetBaseDamageMin())
end

function Opal:OnAttackLanded(keys)
end

function Opal:OnAttackStart(keys)
end