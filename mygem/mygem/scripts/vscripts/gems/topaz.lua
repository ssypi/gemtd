Topaz = {
    maxTargets = {3,4,5,6,7,8}
}

function Topaz:OnCreated(keys)
    print("Topaz created")
end

function Topaz:OnAttackLanded(keys)

end

function Topaz:OnAttackStart(keys)
    local target = keys.target
    local qualityNum = self.qualityNum
    local range = self:GetAttackRange()
    local units = FindUnitsInRadius(target:GetTeam(), target:GetOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)

    local count = 0
    local maxTargets = Topaz.maxTargets[qualityNum]

    for _, unit in pairs(units) do
        if unit ~= target then
            self:PerformAttack(unit, false, false, true, false)
            count = count + 1
            if count >= maxTargets then
                break
            end
        end
    end
end