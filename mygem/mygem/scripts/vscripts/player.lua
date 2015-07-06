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
    player:CreateBuilder()
    player:CreateBase()
    player.state = Build.new(player)
    player.state:Begin()
end

function Player:CreateBuilder()
    -- local hero = CreateHeroForPlayer('npc_dota_hero_viper', self)
    local hero = self:GetAssignedHero()
    local qualityAbility = hero:FindAbilityByName("builder_upgrade_quality")
    if qualityAbility ~= nil then
        qualityAbility:SetLevel(1)
    end

    --    hero:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
    hero:SetGold(10, false)
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
