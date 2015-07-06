local currentWaypoint = 1
local waypoints = {}
local moving = false

local endCallback = function () print("no end callback provided") end

local TARGET_RANGE = 200

function DispatchOnPostSpawn(scope, waypointTable, lastWpCallback)
    waypoints = waypointTable
    endCallback = lastWpCallback
    thisEntity:SetThink("DudeThink", self, "DudeThinker", 0.5)
end

function DudeThink()
    local moveTarget = waypoints[currentWaypoint]:GetOrigin()

    if moving then
        local wpReached = thisEntity:IsPositionInRange(moveTarget, TARGET_RANGE)
        if wpReached then
            currentWaypoint = currentWaypoint + 1
            moving = false
            if currentWaypoint > #waypoints then
                print("Reached last waypoint")
                Explode()
            end
        else
            OrderMoveToPos(moveTarget)
            -- TODO: Check if stuck
            -- Re-order?
        end
    else
        OrderMoveToPos(moveTarget)
        moving = true
    end
    return 0.5
end

function Explode()
    -- TODO: Add particles
    ParticleManager:CreateParticle("particles/generic_gameplay/generic_hit_blood.vpcf", PATTACH_ABSORIGIN, thisEntity)
    thisEntity:ForceKill(true)
--    UTIL_Remove(thisEntity)
    endCallback()
end

function OrderMoveToPos(targetPos)
    ExecuteOrderFromTable({
        UnitIndex = thisEntity:entindex(),
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
        Position = targetPos
    })
end
