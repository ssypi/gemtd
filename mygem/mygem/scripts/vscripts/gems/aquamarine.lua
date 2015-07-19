Aquamarine = {}

function Aquamarine:OnCreated(keys)
    print("Aquamarine created")
    self:SetRenderColor(55, 189, 189)
end

function Aquamarine:OnAttackLanded(keys)
    print("Damage: " .. keys.damage)
end

function Aquamarine:OnAttackStart(keys)
end