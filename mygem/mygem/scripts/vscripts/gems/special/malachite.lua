Malachite = {
    maxTargets = {3,4,10}
}

function Malachite:OnCreated(keys)
    local quality = 1
    if vlua.find(self:GetUnitName(), "vivid") ~= nil then
        quality = 2
    elseif vlua.find(self:GetUnitName(), "mighty") ~= nil then
        quality = 3
    end
    self.qualityNum = quality
end

function Malachite:OnAttackStart(keys)
    local target = keys.target
    local qualityNum = self.qualityNum
    local range = self:GetAttackRange()
    print(range)
    local units = FindUnitsInRadius(target:GetTeam(), self:GetOrigin(), nil, range, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)

    local count = 0
    local maxTargets = Malachite.maxTargets[qualityNum]

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
