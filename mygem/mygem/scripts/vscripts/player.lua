if Player == nil then
    Player = {}
end


function Player.InitAll(players)
    for _, player in pairs(players) do
        Player.Init(player)
    end
end


function Player.Init(player)
    print("Initializing player#" .. player:GetPlayerID())
    CopyFunctions(Player, player)
    player.gems = {}
    player.allGems = {}
    player.currentRound = 1
    player:CreateSpawner()
    player:CreateBase()
    player:CreateBuilder()
end

function Player:CreateSpawner()
    local playerId = self:GetPlayerID()
    print("Creating spawner for player#" .. playerId)
    local spawnPoint = Entities:FindAllByName("spawn_point_p" .. playerId)
    if spawnPoint ~= nil and #spawnPoint > 0 then
        local spawner = CreateUnitByName("npc_dude_spawner", spawnPoint[1]:GetAbsOrigin(), true, nil, nil, DOTA_TEAM_BADGUYS)

        local waypoints = {}

        local i = 1
        repeat
            local wpName = "waypoint_p" .. playerId .. "_w" .. i
            local wp = Entities:FindByName(nil, wpName)
            table.insert(waypoints, wp)
            i = i + 1
        until wp == nil

        spawner.waypoints = waypoints
        self.spawner = spawner
        print("Spawner created for player#" .. playerId .. " with " .. #spawner.waypoints .. " waypoints")
        --scope:DispatchOnPostSpawn()
        --table.insert(spawners, spawner)
    else
        print("Spawn point not found for player#" .. playerId)
    end
end

function Player:CreateBuilder()
    -- local hero = CreateHeroForPlayer('npc_dota_hero_viper', self)
    local hero = self:GetAssignedHero()
    if hero == nil then
        print("Hero not found for player#" .. self:GetPlayerID() .. ", waiting")
        self:SetThink(function()
            print("kalakalakala thinker")
            self:CreateBuilder()
            return nil
        end, 1)
    else
        print("Setting builder abilities for player " .. self:GetPlayerID())
        local qualityAbility = hero:FindAbilityByName("builder_upgrade_quality")
        if qualityAbility ~= nil then
            qualityAbility:SetLevel(1)
        end
        --    hero:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
        hero:SetGold(10, false)

        self.state = Build.new(self)
        self.state:Begin()
    end
end

function Player:ChangeTeam(newTeam)
    local oldTeam = self:GetTeam()
    local hero = self:GetAssignedHero()
    hero:SetTeam(newTeam)
    self:SetTeam(newTeam)
    PlayerResource:UpdateTeamSlot(self:GetPlayerID(), newTeam)
end

function Player:CreateBase()
    local pId = self:GetPlayerID()
    print("Creating base for player#" .. pId)
    local hero = self:GetAssignedHero()
    local target = Entities:FindByName(nil, "spawn_base_" .. pId)
    if target == nil then
        print("No spawner found for player#" .. pId)
    else
        local base = CreateUnitByName("player_base", target:GetAbsOrigin(), false, hero, hero, self:GetTeam())
        base:SetControllableByPlayer(pId, true)
        base:SetForwardVector(target:GetForwardVector())
        base:SetHealth(15)
        self.base = base
    end
end

function Player:ShowError(message)
    print("Showing error: " .. message)
    FireGameEvent("custom_error_show", {
        player_ID = self:GetPlayerID(),
        _error = message
    })
end
