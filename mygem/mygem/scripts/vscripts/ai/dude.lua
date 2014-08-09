local currentWaypoint = 1
local waypoints = {}

local TARGET_RANGE = 200

function DispatchOnPostSpawn(scope, waypointTable)
    waypoints = waypointTable
    thisEntity:SetThink("DudeThink", self, "DudeThinker", 1)
end

function DudeThink()
    local moveTarget = waypoints[currentWaypoint]:GetOrigin()

    local wpReached = thisEntity:IsPositionInRange(moveTarget, TARGET_RANGE)
    if not wpReached then
--        print("moving to wp#" .. currentWaypoint)
        ExecuteOrderFromTable({
            UnitIndex = thisEntity:entindex(),
            OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
            Position = moveTarget
        })
    else
        currentWaypoint = currentWaypoint + 1
        if #waypoints < currentWaypoint then
            currentWaypoint = 1
        end
--        print("Target reached, next wp#" .. currentWaypoint)
    end
    return 1
end