Amethyst = {}

function Amethyst:OnCreated(keys)
    print("Amethyst created")
    self:SetRenderColor(190, 55, 190)
end

function Amethyst:OnAttackLanded(keys)
    print("Damage: " .. keys.damage)
end

function Amethyst:OnAttackStart(keys)
end