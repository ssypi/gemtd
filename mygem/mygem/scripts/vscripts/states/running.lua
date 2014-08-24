Running = {}
Running.__index  = Running

local TIME_BETWEEN_SPAWN = 1

function Running.new(player)
    local runState = {}
    setmetatable(runState, Running)
    runState.player = player
end

function Running:KillAll()
    for i=1, #self.dudes do
        local dude = self.dudes[i]
        if IsValid(dude) and dude:IsAlive() then
            dude:ForceKill(true)
        end
    end
end

function Running:Begin()
    local player = self.player
    print("Running state started for " .. player:GetPlayerID())
    self.done = false
    self.currentRound = 0
    self.dudes = {}
    self.lastSpawnTime = 0
    self:StartNextRound()
end

function Running:StartNextRound()
    local player = self.player
    if self.currentRound >= #Levels then
        print("All rounds completed!")
        -- TODO: end, don't start from beginning
        self.currentRound = 1
--        self.done = true
    else
        self.currentRound = self.currentRound + 1
        print("Starting round #" .. self.currentRound)
        self.dudes = {}
    end
end

function Running:Update()
    if self.done then
        print("Doned")
        return
    end
    local currentTime = GameRules:GetGameTime()

    if #self.dudes >= Levels[self.currentRound].count then
        if IsEveryoneDead() then
            print("All dudes dead, level finished!")
            self.done = true
        end
    elseif currentTime - self.lastSpawnTime > TIME_BETWEEN_SPAWN then
        self.lastSpawnTime = currentTime
        self:SpawnDude()
    end
end

function Running:SpawnDude()
    local player = self.player
    print("Spawning dude, current count: " .. #self.dudes)
    local spawnPoint = player.spawner:GetOrigin()
    local currentUnit = Levels[self.currentRound].unit
    local dude = CreateUnitByName(currentUnit, spawnPoint, true, nil, nil, DOTA_TEAM_BADGUYS)
    table.insert(self.dudes, dude)
    local scope = dude:GetPrivateScriptScope()
    scope:DispatchOnPostSpawn(player.spawner.waypoints, function () DamagePlayer(player)  end)
end

function DamagePlayer(player)

end

function IsEveryoneDead()
    for i = 1, #self.dudes do
        local dude = self.dudes[i]
        if IsValid(dude) and dude:IsAlive() then
            return false
        end
    end
    return true
end

function Running:End()
    local player = self.player
    print("Running state ended for " .. player:GetPlayerID())
    self.nextState = Build.new(player)
end