require("util")
require("states/build")
require("states/running")
require("mygem")


-- This chunk of code forces the reloading of all modules when we reload script.
if g_reloadState == nil then
    g_reloadState = {}
    for k, v in pairs(package.loaded) do
        g_reloadState[k] = v
    end
else
    for k, v in pairs(package.loaded) do
        if g_reloadState[k] == nil then
            package.loaded[k] = nil
        end
    end
end


if MyGemGameMode == nil then
	MyGemGameMode = class({})
end

function Precache( context )
    --PrecacheUnitByName('npc_precache_everything')

    --[[
        Precache things we know we'll use.  Possible file types include (but not limited to):
            PrecacheResource( "model", "*.vmdl", context )
            PrecacheResource( "soundfile", "*.vsndevts", context )
            PrecacheResource( "particle", "*.vpcf", context )
            PrecacheResource( "particle_folder", "particles/folder", context )
    ]]
    PrecacheResource("model", "models/developmoent/invisiblebox.vmdl", context)
    PrecacheResource("model", "models/props_gameplay/sheep01.vmdl", context)
    PrecacheResource("model", "models/effects/dust_00.vmdl", context)
    PrecacheUnitByNameSync("npc_dota_building", context)
    PrecacheUnitByNameSync("maze_tester", context)
    PrecacheUnitByNameSync("npc_dota_goodguys_tower1_top", context)
    PrecacheUnitByNameSync("npc_dota_badguys_tower1_top", context)
    PrecacheUnitByNameSync("item_place_building_free", context)
    PrecacheUnitByNameSync("npc_dota_hero_viper", context)
    PrecacheResource("model", "models/buildings/building_plain_reference.vmdl", context)
    PrecacheResource("model", "models/player.vmdl", context)
    PrecacheResource("model", "models/courier/donkey_unicorn/donkey_unicorn.vmdl", context)

    PrecacheResource("model", "models/buildings/building_racks_ranged_reference.vmdl", context)
    PrecacheResource("model", "models/buildings/building_racks_melee_reference.vmdl", context)
    --PrecacheResource("particle", "particles/status_fx/status_effect_building_placement_good.vpcf", context)
    --PrecacheResource("particle", "particles/status_fx/status_effect_building_placement_bad.vpcf", context)
    --PrecacheResource("particle", "status_effect_building_placement_good.vpcf", context)
    --PrecacheResource("particle", "status_effect_building_placement_bad.vpcf", context)
    --PrecacheResource("particle", "*.projected_square.vpcf", context)
    PrecacheResource("particle_folder", "particles/ui_mouseactions", context)
    PrecacheResource("particle_folder", "particles/econ/generic/generic_buff_1", context)
    PrecacheResource("particle_folder", "particles/status_fx", context)
    PrecacheResource("particle_folder", "particles/base_attacks", context)
    --PrecacheResource("particle", "particles/units/heroes/hero_viper.vpcf", context)
    --PrecacheResource("soundfile", "scripts/game_sounds_heroes/game_sounds_viper.txt", context)
end


-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = MyGemGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function MyGemGameMode:InitGameMode()
	print( "Template addon is loaded." )
    local game = GameRules:GetGameModeEntity()
    game:SetThink( "OnThink", self, "GlobalThink", 2 )
    --game:ClientLoadGridNav()

    Convars:RegisterCommand('tester', function(name)
    -- Check if the server ran it
        local player = Convars:GetCommandClient()
        print(player)
        print(player:GetAssignedHero())
        if player.spawner ~= nil then
            player.spawner:GetPrivateScriptScope():SpawnMazeTester()
        end
    end, '', 0)

    GameRules:SetPreGameTime(10.0)
    GameRules:SetGoldPerTick(0)
    game:SetFogOfWarDisabled(true)
    game:SetTopBarTeamValuesVisible(false)
    game:SetAlwaysShowPlayerInventory(true)
--    game:SetGoldSoundDisabled(true)


    ListenToGameEvent('player_connect_full', Dynamic_Wrap(MyGemGameMode, 'AutoAssignPlayer'), self)

end


-- A function to re-lookup a function by name every time.
function Dynamic_Wrap(mt, name)
    if Convars:GetFloat('developer') == 1 then
        local function w(...) return mt[name](...) end
        return w
    else
        return mt[name]
    end
end


-- Evaluate the state of the game
function MyGemGameMode:OnThink()
	if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        if not MyGemGameMode.started then
            MyGemGameMode:Start()
        end
		--print( "Template addon script is running." )
	elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
		return nil
	end
	return 1
end

