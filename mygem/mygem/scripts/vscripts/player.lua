if Player == nil then
    Player = {}
end


function Player:CreateBuilder()
    local hero = CreateHeroForPlayer('npc_dota_hero_viper', self)
    hero:FindAbilityByName("builder_upgrade_quality"):SetLevel(1)
    hero:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
end

function Player.Init(player)
    CopyFunctions(Player, player)
    player.state = Build.new(player)
    player.state:Begin()
    player.gems = {}
    player.allGems = {}
    table.insert(MyGemGameMode.players, player)
    player:SetTeam(DOTA_TEAM_GOODGUYS)
    player:CreateBuilder()
end
