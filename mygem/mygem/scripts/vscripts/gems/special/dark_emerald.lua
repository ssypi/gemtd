DarkEmerald = {}

local ABILITY_STUN = "dark_emerald_stun"

function DarkEmerald:OnCreated(keys)
    print("Dark Emerald onCreated")
    local quality = 1
    if vlua.find(self:GetUnitName(), "enchanted_emerald") ~= nil then
        quality = 2
    end
    self.qualityNum = quality

    self:AddAbility(ABILITY_STUN)
    self:FindAbilityByName(ABILITY_STUN):SetLevel(self.qualityNum)
end

function DarkEmerald:OnAttackStart(keys)
    local target = keys.target

end

function DarkEmerald:OnAttackLanded(keys)
    local target = keys.target
    print("Dark Emerald attack landed")

end

