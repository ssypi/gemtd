Running = {}
Running.__index = Running

local TIME_BETWEEN_SPAWN = 2

function Running.new(player)
    local runState = {}
    setmetatable(runState, Running)
    runState.player = player
    return runState
end

function Running:KillAll()
    for i = 1, #self.dudes do
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
    self.currentRound = player.currentRound
    self.dudes = {}
    self.lastSpawnTime = 0
    self:StartRound()
end

function Running:StartRound()
    local player = self.player
    if self.currentRound >= #Levels then
        print("All rounds completed!")
        -- TODO: end, don't start from beginning
        self.currentRound = 1
        --        self.done = true
    else
        print("Starting round #" .. self.currentRound)
        self.dudes = {}
        self:CheckAirRound()
    end
end

function Running:CheckAirRound()
    EnableAllGems(self.player)
    if self.currentRound % 4 == 0 then
        print("Air round!")
        DisableGroundOnlyGems(self.player)
    else
        DisableAirOnlyGems(self.player)
    end
end

function EnableAllGems(player)
    local gems = player.allGems
    for _, gem in pairs(gems) do
        gem:Enable()
    end
end

function DisableAirOnlyGems(player)
    local gems = player.allGems
    for _, gem in pairs(gems) do
        gem:DisableIfAirOnly()
    end
end

function DisableGroundOnlyGems(player)
    local gems = player.allGems
    for _, gem in pairs(gems) do
        gem:DisableIfGroundOnly()
    end
end

function Running:Update()
    if self.done then
        print("Doned")
        return
    end
    local currentTime = GameRules:GetGameTime()

    if #self.dudes >= Levels[self.currentRound].count then
        if self:IsEveryoneDead() then
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
    local particleId = ParticleManager:CreateParticle("particles/dark_smoke_test.vpcf", PATTACH_ABSORIGIN, player.spawner)
    dude:SetThink(function()
        ParticleManager:DestroyParticle(particleId, false)
        return nil
    end, 2)
    table.insert(self.dudes, dude)
    local scope = dude:GetPrivateScriptScope()
    scope:DispatchOnPostSpawn(player.spawner.waypoints, function() self:DamagePlayer() end)
end

function Running:DamagePlayer()
    local player = self.player
    local base = player.base

    if not IsValid(base) then
        self:Lose()
    else
        if not self.player.lost then
            EmitSoundOn("Roshan.Attack", base)
        end
        ApplyDamage({
            attacker = base,
            victim = base,
            damage = 1,
            damage_type = DAMAGE_TYPE_PURE
        })
        if not base:IsAlive() then
            if not self.player.lost then
                EmitSoundOn("techies_super_explosion", player)
                self:KillAll()
                AddFOWViewer(player:GetTeam(), base:GetAbsOrigin(), 1000, 10, false)
                ParticleManager:CreateParticle("particles/addons_gameplay/pit_lava_blast.vpcf", PATTACH_ABSORIGIN, base)
            end
            self:Lose()
        end
    end
end

function Running:Lose()
    self.player.lost = true;
    self.player:GetAssignedHero():ForceKill(true)
    print("Game over!")
end

function Running:IsEveryoneDead()
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
    local hero = player:GetAssignedHero()
    local goldBonus = 5 + (self.currentRound * 2)
    hero:SetGold(hero:GetGold() + goldBonus, false)
    print("Running state ended for " .. player:GetPlayerID())
    self.nextState = Build.new(player)
    player.currentRound = self.currentRound + 1

    if player.currentRound % 4 == 0 then
        CustomGameEventManager:Send_ServerToPlayer(player, "show_notification", { notification = "Next round is air" })
    end
end