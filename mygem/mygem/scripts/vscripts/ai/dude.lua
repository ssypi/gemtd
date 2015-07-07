local currentWaypoint = 1
local waypoints = {}
local moving = false

local endCallback = function() print("no end callback provided") end

local TARGET_RANGE = 200

function DispatchOnPostSpawn(scope, waypointTable, lastWpCallback)
    waypoints = waypointTable
    endCallback = lastWpCallback
    print("spawning dude with " .. #waypointTable .. " waypoints")
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
                return Explode()
            end
        else
            OrderMoveToPos(moveTarget)
            -- TODO: Check if stuck
            if thisEntity:IsIdle() then
                local units = FindUnitsInRadius(thisEntity:GetTeam(), thisEntity:GetAbsOrigin(), nil, 250,
                    DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false)
                if #units > 0 then
                    local unit = units[1]
                    print("Dude stuck and doing damage to " .. unit:GetUnitName())
                    ApplyDamage({
                        attacker = thisEntity,
                        victim = unit,
                        damage = 2,
                        damage_type = DAMAGE_TYPE_PURE
                    })
                    local player = unit:GetOwner()
                    if not player.underAttackPlayed then
                        EmitSoundOnClient("announcer_dlc_pflax_announcer_anc_attack_yr_03", unit:GetOwner())
                        player.underAttackPlayed = true
                    end
                    unit:SetThink(function()
                        player.underAttackPlayed = false
                        return nil
                    end, 5)
                    if not unit:IsAlive() then
                        if unit.blocker ~= nil then
                            print("Removing blocker")
                            DoEntFireByInstanceHandle(unit.blocker, "Disable", "1", 0, nil, nil)
                            DoEntFireByInstanceHandle(unit.blocker, "Kill", "1", 1, nil, nil)
                        else
                            print("Gem has no blocker?")
                        end
                        UTIL_Remove(unit)
                    end
                end
            end
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
    return nil
end

function OrderMoveToPos(targetPos)
    ExecuteOrderFromTable({
        UnitIndex = thisEntity:entindex(),
        OrderType = DOTA_UNIT_ORDER_MOVE_TO_POSITION,
        Position = targetPos
    })
end
