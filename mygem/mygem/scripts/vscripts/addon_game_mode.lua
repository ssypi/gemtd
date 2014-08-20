require("util")
require("states/build")
require("states/running")
require("mygem")
require("test")


function kala()
    print ("kala")
end

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
    PrecacheResource("model", "models/development/invisiblebox.vmdl", context)
    PrecacheResource("model", "models/props_gameplay/sheep01.vmdl", context)
    PrecacheResource("model", "models/effects/dust_00.vmdl", context)
    PrecacheResource("model", "models/courier/drodo/drodo.vmdl", context)
    PrecacheResource("model", "models/props_tree/dire_tree003.vmdl", context)
    PrecacheResource("model", "models/courier/smeevil_magic_carpet/smeevil_magic_carpet_flying.vmdl", context)
    PrecacheResource("model", "models/creeps/lane_creeps/creep_bad_melee_diretide/creep_bad_melee_diretide.vmdl", context)
    PrecacheUnitByNameSync("npc_dota_building", context)
    PrecacheUnitByNameSync("npc_dota_unit_undying_zombie", context)
    PrecacheUnitByNameSync("courier_smeevil_flying_carpet", context)
    PrecacheUnitByNameSync("npc_courier_smeevil_flying_carpet", context)
    PrecacheUnitByNameSync("maze_tester", context)
    PrecacheUnitByNameSync("npc_dota_goodguys_tower1_top", context)
    PrecacheUnitByNameSync("npc_dota_badguys_tower1_top", context)
    PrecacheUnitByNameSync("item_place_building_free", context)
    PrecacheUnitByNameSync("npc_dota_hero_viper", context)
    PrecacheResource("model", "models/buildings/building_plain_reference.vmdl", context)
    PrecacheResource("model", "models/player.vmdl", context)
    PrecacheResource("model", "models/gem_chipped_ruby.vmdl", context)
    PrecacheResource("model", "models/courier/donkey_unicorn/donkey_unicorn.vmdl", context)

    PrecacheResource("model", "models/buildings/building_racks_ranged_reference.vmdl", context)
    PrecacheResource("model", "models/buildings/building_racks_melee_reference.vmdl", context)
    PrecacheResource("model", "models/gem_blue/gem_blue.vmdl", context)
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
    PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile_model.vpcf", context)
    PrecacheResource("particle", "particles/base_attacks/generic_projectile_trail.vpcf", context)
    --PrecacheResource("soundfile", "scripts/game_sounds_heroes/game_sounds_viper.txt", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_music_int.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/music/valve_dota_001/music/game_sounds_music.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_undying.vsndevts", context)
    PrecacheResource("soundfile", "sounds/music/valve_dota_001/music/countdown.vsnd", context)
end

-- Create the game mode when we activate
function Activate()
	GameRules.AddonTemplate = MyGemGameMode()
	GameRules.AddonTemplate:InitGameMode()
end

function LoadCustomKV()
    MyGemGameMode.kv = {
        units = LoadKeyValues("scripts/npc/npc_units_custom.txt")
        --items = LoadKeyValues("scripts/npc/npc_items_custom.txt")
    }
end

function MyGemGameMode:InitGameMode()
	print( "Template addon is loaded." )
    LoadCustomKV()
    local game = GameRules:GetGameModeEntity()
    game:SetCameraDistanceOverride(1300)
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
--function Dynamic_Wrap(mt, name)
--    if Convars:GetFloat('developer') == 1 then
--        local function w(...) return mt[name](...) end
--        return w
--    else
--        return mt[name]
--    end
--end


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

