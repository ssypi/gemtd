
function IsInsideNoBuildZone(unit)
    local zones = Entities:FindAllByName("zone_no_build")
    for _, zone in pairs(zones) do
        local center = zone:GetCenter()
        local max = center + zone:GetBoundingMaxs()
        local min = center + zone:GetBoundingMins()
        local unitPos = unit:GetAbsOrigin()
        local touchesX = (unitPos.x < max.x and unitPos.x > min.x)
        local touchesY = (unitPos.y < max.y and unitPos.y > min.y)
        if touchesX and touchesY then
            return true
        end
    end
    return false
end


function BuildTest(keys)
    local caster = keys.caster

    print("attacker:", caster:GetEntityIndex())
    print("ability:", keys.ability:GetEntityIndex())
    ApplyDamage({
        attacker=caster,
        victim=caster,
        damage=10,
        damage_type=DAMAGE_TYPE_PHYSICAL,
        ability=keys.ability,
        damage_flags=0
    })

    local player = caster:GetPlayerOwner()
    local target = keys.target_points[1]
    if player.gems == nil then
        player.gems = {}
    end

    local diffX = target.x % 64
    local diffY = target.y % 64

    if diffX > 32 then
        diffX = diffX - 64
    end
    if diffY > 32 then
        diffY = diffY - 64
    end

    target.x = target.x - diffX
    target.y = target.y - diffY

    CreateUnitByName("custom_sentry", target, false, nil, nil, DOTA_TEAM_BADGUYS)
--    Gem:CreateRock(target, player)
end

function Build(keys)
    local caster = keys.caster
    local player = caster:GetPlayerOwner()
    local target = keys.target_points[1]

    if player.smallGrid then
        local diffX = target.x % 64
        local diffY = target.y % 64

        if diffX > 32 then
            diffX = diffX - 64
        end
        if diffY > 32 then
            diffY = diffY - 64
        end

        target.x = target.x - diffX
        target.y = target.y - diffY
    else
        target.x = target.x - (target.x % 128) + 64
        target.y = target.y - (target.y % 128) + 64
    end

    -- Check for clear space with a dummy unit, beacause currently buildings have problems with find clear space
    local dummy = CreateUnitByName("gem_dummy", target, true, caster, caster, caster:GetTeamNumber())

    if IsInsideNoBuildZone(dummy) then
        player:ShowError("You are not allowed to build there!")
    elseif dummy:GetOrigin() ~= target then
        player:ShowError("Can't build there!")
    else
        local gem = Gem:CreateGem(Gem:RandomGem(player), target, player)
        gem:AddKeep()
        local item = keys.ability
        item:SetCurrentCharges(item:GetCurrentCharges() - 1)
    end
    UTIL_Remove(dummy)
end