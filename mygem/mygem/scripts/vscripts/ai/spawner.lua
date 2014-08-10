local currentRound = 1
local maxDudes = 5
local currentUnit =  "dude1"

local waypoints = {}

local dudes = {}

local SEARCH_RANGE = 5000.0

function DispatchOnPostSpawn()
    if thisEntity.running == nil then
        thisEntity.running = false
    end

    local wp = Entities:FindByNameNearest("path1", thisEntity:GetOrigin(), SEARCH_RANGE)
    table.insert(waypoints, wp)
    wp = Entities:FindByNameNearest("path2", wp:GetOrigin(), SEARCH_RANGE)
    table.insert(waypoints, wp)
    wp = Entities:FindByNameNearest("path3", wp:GetOrigin(), SEARCH_RANGE)
    table.insert(waypoints, wp)

    thisEntity:SetThink("SpawnerThink", self, "SpawnerThinker", 1)
end

function StartNextRound()
    currentRound = currentRound + 1
    print("Starting round #" .. currentRound)
    dudes = {}
    thisEntity.running = true
end

function IsEveryoneDead()
    for i=1, #dudes do
        local dude = dudes[i]
        if IsValidEntity(dude) and not IsMarkedForDeletion(dude) and dude:IsAlive() then
            return false
        end
    end
    return true
end

function SpawnMazeTester()
    print("Spaning Maze tester")
    local spawnPoint = thisEntity:GetOrigin()
    local tester = CreateUnitByName("maze_tester", spawnPoint, true, nil, nil, DOTA_TEAM_GOODGUYS)
    tester:GetPrivateScriptScope():DispatchOnPostSpawn(waypoints)
end

function SpawnDude()
    print("Spawning dude, current count: " .. #dudes)
    local spawnPoint = thisEntity:GetOrigin()
    local dude = CreateUnitByName(currentUnit, spawnPoint, true, nil, nil, DOTA_TEAM_BADGUYS)
    table.insert(dudes, dude)
    local scope = dude:GetPrivateScriptScope()
    scope:DispatchOnPostSpawn(waypoints)
end

function SpawnerThink()
    if not thisEntity.running then
        return 1
    end

    thisEntity.finished = false

    if #dudes < maxDudes then
        SpawnDude()
    end

    if IsEveryoneDead() then
        print("All dudes dead, level finished!")
        thisEntity.running = false
        thisEntity.finished = true
    end

    return 1
end


