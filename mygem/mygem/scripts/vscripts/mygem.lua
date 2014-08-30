print("MYGEM LOADED")

if MyGemGameMode == nil then
    MyGemGameMode = class({})
end

local spawners = {}

MyGemGameMode.players = {}

function GGTest(trigger, keys, a, b, c)
    print(trigger)
    print(keys)
    print(a)
    print(b)
    print(c)
    PrintTable(keys)
end

function MyGemGameMode:Start()
    Player.InitAll(MyGemGameMode.players)
    CreateSpawners()
    MyGemGameMode.started = true
    GameRules:GetGameModeEntity():SetThink("GameLoop", self, "gameThinker", 1)
--    for i=1, #spawners do
--        spawners[i].running = true
--    end
end

-- TODO: We should create one for each player and set it to player.spawner
function CreateSpawners()
    local spawnPoints = Entities:FindAllByName("spawn_point")
    if #spawnPoints ~= 0 then
        for i = 1, #spawnPoints do
            --            local dudes = FindUnitsInRadius(DOTA_TEAM_BADGUYS, Vector(0,0,0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_ALL, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
            local spawnPoint = spawnPoints[i]:GetOrigin()
            local spawner = CreateUnitByName("npc_dude_spawner", spawnPoint, true, nil, nil, DOTA_TEAM_BADGUYS)
            local scope = spawner:GetPrivateScriptScope()

            local waypoints = {}

            local playerNum = 1

            local i = 1
            repeat
                local wpName = "waypoint_p" .. playerNum .. "_w" .. i
                local wp = Entities:FindByName(nil, wpName)
                table.insert(waypoints, wp)
                i = i+1
            until wp == nil

            spawner.waypoints = waypoints
            --scope:DispatchOnPostSpawn()
            table.insert(spawners, spawner)
        end
    end
end

function MyGemGameMode:GameLoop()
    local players = MyGemGameMode.players

    for i = 1, #spawners do
        local spawner = spawners[i]
        if players[i] ~= nil then
            players[i].spawner = spawner
        end
    end

    for i=1, #players do
        local player = players[i]
        local state = player.state
        if state.done then
            state:End()
            state = state.nextState
            player.state = state
            state:Begin()
        end
        state:Update()
    end

    return 0.05
end

function MyGemGameMode:AutoAssignPlayer(keys)
    -- Grab the entity index of this player
    local entIndex = keys.index + 1
    local player = EntIndexToHScript(entIndex)
    player:SetTeam(DOTA_TEAM_GOODGUYS)

    table.insert(MyGemGameMode.players, player)
    --player:__KeyValueFromInt('teamnumber', DOTA_TEAM_GOODGUYS)
end