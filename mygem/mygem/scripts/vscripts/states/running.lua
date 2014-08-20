if Running == nil then
    Running = {}
end

local currentRound = 0
local dudes = {}
local lastSpawnTime = 0
local cooldown = 1

function Running.Begin(player)
    print("Running state started for " .. player:GetPlayerID())
    Running.done = false
    StartNextRound(player)
end

function StartNextRound(player)
    local hero = player:GetAssignedHero()
    print("kala: " .. hero.kalamies)
    if currentRound >= #Levels then
        print("All rounds completed!")
        Running.done = true
    else
        currentRound = currentRound + 1
        print("Starting round #" .. currentRound)
        dudes = {}
    end
end

function Running.Update(player)
    if Running.done then
        print("Doned")
        return
    end
    local currentTime = GameRules:GetGameTime()

    if #dudes >= Levels[currentRound].count then
        if IsEveryoneDead() then
            print("All dudes dead, level finished!")
            Running.done = true
        end
    elseif currentTime - lastSpawnTime > cooldown then
        lastSpawnTime = currentTime
        SpawnDude(player)
    end
end

function SpawnDude(player)
    print("Spawning dude, current count: " .. #dudes)
    local spawnPoint = player.spawner:GetOrigin()
    local currentUnit = Levels[currentRound].unit
    local dude = CreateUnitByName(currentUnit, spawnPoint, true, nil, nil, DOTA_TEAM_BADGUYS)
    table.insert(dudes, dude)
    local scope = dude:GetPrivateScriptScope()
    scope:DispatchOnPostSpawn(player.spawner.waypoints, function () DamagePlayer(player)  end)
end

function DamagePlayer(player)

end

function IsEveryoneDead()
    for i = 1, #dudes do
        local dude = dudes[i]
        if IsValidEntity(dude) and not IsMarkedForDeletion(dude) and dude:IsAlive() then
            return false
        end
    end
    return true
end

function Running.End(player)
    print("Running state ended for " .. player:GetPlayerID())
    Running.nextState = Build
end