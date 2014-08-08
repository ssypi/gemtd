print("MYGEM LOADED")

if MyGemGameMode == nil then
    MyGemGameMode = class({})
end

function KillTrigger(trigger, keys)
    keys.activator:ForceKill(true)
end

function MyGemGameMode:AutoAssignPlayer(keys)
    -- Grab the entity index of this player
    local entIndex = keys.index + 1
    local player = EntIndexToHScript(entIndex)


    player:SetTeam(DOTA_TEAM_GOODGUYS)
    --player:__KeyValueFromInt('teamnumber', DOTA_TEAM_GOODGUYS)

    CreateHeroForPlayer('npc_dota_hero_viper', player)

    -- Set Global variable hero for debugging
    -- TODO: remove later
    local hero = player:GetAssignedHero()

    local item = CreateItem("item_quelling_blade", hero, hero)
    local item2 = CreateItem("item_placerock", hero, hero)
    local item3 = CreateItem("item_place_building", hero, hero)
    hero:AddItem(item)
    hero:AddItem(item2)
    hero:AddItem(item3)

    GameRules:GetGameModeEntity():ClientLoadGridNav()

    -- Disable attack (5 = DOTA_UNIT_CAP_NO_ATTACK)
    hero:SetMoveCapability(5)
end