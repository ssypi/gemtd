local RANGE_ATTACK = 500 -- Target acquire distance
local RANGE_CHASE = 1500 -- Chase distance from original position
local RANGE_RESET = 200 -- Starts re-looking for targets when returned this close to original pos after stopping chase
local TIME_CHECK = 5    -- Seconds to wait before checking if out of chase range

local BEHAVIOR = {
    IDLE = 1,
    ATTACKING = 2,
    RETURNING = 3
}

function Activate()
    print("Sentry spawned")

    thisEntity.isReturning = false
    thisEntity.isAttacking = false
    thisEntity.behavior = BEHAVIOR.IDLE

    -- Disable regular acquisition ai
    thisEntity:SetIdleAcquire(false)
    thisEntity:SetAcquisitionRange(0)

    -- We wait one frame before setting the position incase the unit gets moved right after spawning
    thisEntity:SetThink("SetGuardSpot")

    thisEntity:SetThink("SentryThink", 5)
end

function SetGuardSpot()
    thisEntity.guardSpot = thisEntity:GetAbsOrigin()
end

function SentryThink()
    local isInRange = thisEntity:IsPositionInRange(thisEntity.guardSpot, RANGE_CHASE)

    if not isInRange then
        return MoveBack()
    end

    if thisEntity.behavior == BEHAVIOR.RETURNING then
        local isCloseEnough = thisEntity:IsPositionInRange(thisEntity.guardSpot, RANGE_RESET)
        if isCloseEnough then
            thisEntity.behavior = BEHAVIOR.IDLE
        else
            return 0.1
        end
    elseif thisEntity.behavior == BEHAVIOR.IDLE then
        local enemies = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil, RANGE_ATTACK, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
        if #enemies == 0 then
            --print("Sentry found no enemies")
            --return MoveBack()
        else
            return AttackClosest(enemies)
        end
    else
        if thisEntity:IsIdle() then
            print("Is idle!")
            MoveBack()
        else
            print("Attaack")
        end
    end

    return 0.1
end

function MoveBack()
    ExecuteOrderFromTable({
        UnitIndex = thisEntity:entindex(),
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
        Position = thisEntity.guardSpot
    })
    thisEntity.behavior  = BEHAVIOR.RETURNING
    return 0.1
end

function AttackClosest(enemies)
    if #enemies == 0 then
        return 0.1
    end

    local target = enemies[1]
    if target ~= nil then
        --print("Attacking " .. target:GetUnitName())
        thisEntity.behavior = BEHAVIOR.ATTACKING
        ExecuteOrderFromTable({
            UnitIndex = thisEntity:entindex(),
            OrderType = DOTA_UNIT_ORDER_ATTACK_TARGET,
            TargetIndex = target:entindex()
        })
        return TIME_CHECK
    end

    return 0.1
end