print("MYGEM LOADED")

if MyGemGameMode == nil then
    MyGemGameMode = class({})
end

local spawners = {}

MyGemGameMode.players = {}

function MyGemGameMode:Start()
    CreateSpawners()
    MyGemGameMode.started = true
    GameRules:GetGameModeEntity():SetThink("GameLoop", self, "gameThinker", 1)
--    for i=1, #spawners do
--        spawners[i].running = true
--    end
end

function CreateRock(pos, owner)
    local rock = CreateUnitByName("npc_mygem_building_rock", pos, false, owner, owner, DOTA_TEAM_GOODGUYS)
    rock:SetControllableByPlayer(owner:GetPlayerID(), true)
    local gridNavBlocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", {
        origin = pos
    })
    rock.blocker = gridNavBlocker
end

function RemoveRock(rock)
    print("Removing rock")
    if rock.blocker ~= nil then
        print("Removing blocker")
        DoEntFireByInstanceHandle(rock.blocker, "Disable", "1", 0, nil, nil)
        DoEntFireByInstanceHandle(rock.blocker, "Kill", "1", 1, nil, nil)
--        UTIL_Remove(rock.blocker)
    end
    UTIL_Remove(rock)
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

--[[
    for players
     if player.state.done then
        player.state.end -- call current state's end transition
        player.state.done = false
        player.state = player.state.nextState
        player.state.begin(player) -- call new state's begin transition
     player.state.thinker(player)
 ]]

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
            state.End(player)
            state.done = false
            state = state.nextState
            player.state = state
            state.Begin(player)
        end
        state.Update(player)
    end

    return 0.05
end

function KillTrigger(trigger, keys)
    keys.activator:ForceKill(true)
end

function GiveBuilderToPlayer(player)
    local hero = CreateHeroForPlayer('npc_dota_hero_viper', player)
    hero:FindAbilityByName("builder_upgrade_quality"):SetLevel(1)
    hero:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
end

function InitPlayer(player)
    player.state = Build
    player.state.Begin(player)
    player.gems = {}
    player.allGems = {}
    table.insert(MyGemGameMode.players, player)
end

function MyGemGameMode:AutoAssignPlayer(keys)
    -- Grab the entity index of this player
    local entIndex = keys.index + 1
    local player = EntIndexToHScript(entIndex)


    player:SetTeam(DOTA_TEAM_GOODGUYS)
    --player:__KeyValueFromInt('teamnumber', DOTA_TEAM_GOODGUYS)

    GiveBuilderToPlayer(player)



--    local item = CreateItem("item_quelling_blade", hero, hero)
--    local item2 = CreateItem("item_placerock", hero, hero)
--    local item3 = CreateItem("item_place_building", hero, hero)
    --hero:AddItem(item)
    --hero:AddItem(item2)
    --hero:AddItem(item3)

    --GameRules:GetGameModeEntity():ClientLoadGridNav()


    InitPlayer(player)
end