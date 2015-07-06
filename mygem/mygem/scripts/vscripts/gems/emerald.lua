Emerald = {
    slow = {
        duration =  {3,4,5,6,8,100},
        damage   =  {2,3,5,8,16,50},
        amount    =  {-15, -20, -25, -30, -50, -50}
    }
}

local MODIFIER_SLOW = "modifier_item_orb_of_venom_slow"

function Emerald:OnAttackLanded(keys)
    local target = keys.target
    print(self.quality)
    local qualityNum = vlua.find(Gem.qualities, self.quality)
    print(qualityNum)
    local slowAmount = Emerald.slow.amount[qualityNum]
    print(slowAmount)
    local damage = Emerald.slow.damage[qualityNum]
    print(damage)
    local duration = Emerald.slow.duration[qualityNum]
    print(duration)
--    target:AddNewModifier(keys.attacker, nil, MODIFIER_SLOW, {
--        slow = slowAmount,
--        duration = duration,
--        damage = damage
--    })
    target:AddAbility("emerald_slow")
    local ability = target:FindAbilityByName("emerald_slow")
    if ability ~= nil then
        ability:SetLevel(qualityNum)
    else
        print("Ability null for emerald_slow")
    end
end

function Emerald:OnAttackStart(keys)

end