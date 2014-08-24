if Player == nil then
    Player = {}
end

function Player.Init(player)
    CopyFunctions(Player, player)
    player.gems = {}
    player.allGems = {}
    table.insert(MyGemGameMode.players, player)
    player:SetTeam(DOTA_TEAM_GOODGUYS)
    player:CreateBuilder()
    player:CreateBase()
    player.state = Build.new(player)
    player.state:Begin()
end

function Player:CreateBuilder()
    local hero = CreateHeroForPlayer('npc_dota_hero_viper', self)
    hero:FindAbilityByName("builder_upgrade_quality"):SetLevel(1)
    hero:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
    hero:SetGold(1000, false)
end

function Player:CreateBase()
    local pId = self:GetPlayerID()
    local hero = self:GetAssignedHero()
    local target = Entities:FindByName(nil, "spawn_base_" .. pId)
    local base = CreateUnitByName("player_base", target:GetAbsOrigin(), false, hero, hero, self:GetTeam())
    base:SetControllableByPlayer(pId, true)
    print(target:GetForwardVector())
    print(target:GetAngles())
    base:SetForwardVector(target:GetForwardVector())
    local ang = target:GetAngles()
    PrintTable(getmetatable(ang))
    PrintTable(ang)
    base:SetHealth(15)
    self.base = base
end

function Player:ShowError(message)
    print("Showing error: " .. message)
    FireGameEvent("custom_error_show",{
        player_ID = self:GetPlayerID(),
        _error = message
    })
end
