if Running == nil then
    Running = {}
end

function Running.Begin(player)
    print("Running state started for " .. player:GetPlayerID())
    Running.done = false
    StartRound(player)
end

function StartRound(player)
    player.spawner:GetPrivateScriptScope():StartNextRound()
end

function Running.Update(player)
    if not player.spawner.running then
        print("Running done for player " .. player:GetPlayerID())
        Running.done = true
    end
end

function Running.End(player)
    print("Running state ended for " .. player:GetPlayerID())
    Running.nextState = Build
end