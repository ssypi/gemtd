print("MYGEM LOADED")

if MyGemGameMode == nil then
    _G.MyGemGameMode = class({})
end

MyGemGameMode.players = {}

function MyGemGameMode:Start()
    Player.InitAll(MyGemGameMode.players)
    MyGemGameMode.started = true
    GameRules:GetGameModeEntity():SetThink("GameLoop", self, "gameThinker", 1)
end

function MyGemGameMode:GameLoop()
    local players = MyGemGameMode.players

    for i = 1, #players do
        local player = players[i]
        local state = player.state
        if state ~= nil then
            if state.done then
                state:End()
                state = state.nextState
                player.state = state
                state:Begin()
            end
            state:Update()
        end
    end

    return 0.05
end

function MyGemGameMode:AutoAssignPlayer(keys)
    -- Grab the entity index of this player
    local entIndex = keys.index + 1
    local player = EntIndexToHScript(entIndex)
    -- player:SetTeam(DOTA_TEAM_GOODGUYS)

    table.insert(MyGemGameMode.players, player)

    if MyGemGameMode.started then
        Player.Init(player)
    end
    --player:__KeyValueFromInt('teamnumber', DOTA_TEAM_GOODGUYS)
end

function MyGemGameMode:OnEntityHurt(keys)
    --PrintTable(keys)
end