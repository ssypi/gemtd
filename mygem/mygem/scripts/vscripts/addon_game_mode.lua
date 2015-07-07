require("util")
require("Gem")
require("player")
require("states/build")
require("states/running")
require("mygem")


if MyGemGameMode == nil then
    _G.MyGemGameMode = class({})
end

function Precache(context)
    --PrecacheUnitByName('npc_precache_everything')
    --[[
        Precache things we know we'll use.  Possible file types include (but not limited to):
            PrecacheResource( "model", "*.vmdl", context )
            PrecacheResource( "soundfile", "*.vsndevts", context )
            PrecacheResource( "particle", "*.vpcf", context )
            PrecacheResource( "particle_folder", "particles/folder", context )
    ]]
--    PrecacheResource("model", "models/heroes/kunkka/kunkka.vmdl", context)
    PrecacheResource("model", "models/development/invisiblebox.vmdl", context)
    PrecacheResource("model", "models/courier/f2p_courier/f2p_courier.vmdl", context)
    PrecacheResource("model", "models/props_debris/skull001.vmdl", context)
    PrecacheResource("model", "models/props_gameplay/sheep01.vmdl", context)
    PrecacheResource("model", "models/effects/dust_00.vmdl", context)
    PrecacheResource("model", "models/courier/drodo/drodo.vmdl", context)
    PrecacheResource("model", "models/props_tree/dire_tree003.vmdl", context)
    PrecacheResource("model", "models/courier/smeevil_magic_carpet/smeevil_magic_carpet_flying.vmdl", context)
    PrecacheResource("model", "models/creeps/lane_creeps/creep_bad_melee_diretide/creep_bad_melee_diretide.vmdl", context)
    PrecacheUnitByNameSync("npc_dota_building", context)
    PrecacheUnitByNameSync("npc_dota_hero_kunkka", context)
    PrecacheUnitByNameSync("npc_dota_brewmaster_fire", context)
    PrecacheUnitByNameSync("npc_dota_brewmaster_fire_1", context)
    PrecacheUnitByNameSync("npc_dota_brewmaster_fire_2", context)
    PrecacheUnitByNameSync("npc_dota_brewmaster_fire_3", context)
    PrecacheUnitByNameSync("npc_dota_unit_undying_zombie", context)
    PrecacheUnitByNameSync("courier_smeevil_flying_carpet", context)
    PrecacheUnitByNameSync("npc_courier_smeevil_flying_carpet", context)
    PrecacheUnitByNameSync("maze_tester", context)
    PrecacheUnitByNameSync("npc_dota_goodguys_tower1_top", context)
    PrecacheUnitByNameSync("npc_dota_badguys_tower1_top", context)
    PrecacheUnitByNameSync("item_place_building_free", context)
    PrecacheUnitByNameSync("npc_dota_hero_viper", context)
    PrecacheUnitByNameSync("gem_special_malachite", context)
    PrecacheResource("model", "models/buildings/building_plain_reference.vmdl", context)
    PrecacheResource("model", "models/player.vmdl", context)
    PrecacheResource("model", "models/gem_chipped_ruby.vmdl", context)
    PrecacheResource("model", "models/courier/donkey_unicorn/donkey_unicorn.vmdl", context)
    PrecacheResource("model", "models/props_structures/tower_good4.vmdl", context)

    PrecacheResource("model", "models/buildings/building_racks_ranged_reference.vmdl", context)
    PrecacheResource("model", "models/buildings/building_racks_melee_reference.vmdl", context)
    PrecacheResource("model", "models/gem_blue/gem_blue.vmdl", context)
    --PrecacheResource("particle", "particles/status_fx/status_effect_building_placement_good.vpcf", context)
    --PrecacheResource("particle", "particles/status_fx/status_effect_building_placement_bad.vpcf", context)
    --PrecacheResource("particle", "status_effect_building_placement_good.vpcf", context)
    --PrecacheResource("particle", "status_effect_building_placement_bad.vpcf", context)
    --PrecacheResource("particle", "*.projected_square.vpcf", context)
    PrecacheResource("particle", "particles/generic_gameplay/lasthit_coins.vpcf", context)
    PrecacheResource("particle_folder", "particles/ui_mouseactions", context)
    PrecacheResource("particle_folder", "particles/units/heroes/hero_brewmaster", context)
    PrecacheResource("particle_folder", "particles/econ/generic/generic_buff_1", context)
    PrecacheResource("particle_folder", "particles/status_fx", context)
    PrecacheResource("particle_folder", "particles/base_attacks", context)
    PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_unstable_concoction_projectile_model.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_phantom_assassin/phantom_assassin_crit_impact.vpcf", context)
    PrecacheResource("particle", "particles/base_attacks/generic_projectile_trail.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_alchemist/alchemist_lasthit_coins.vpcf", context)
    PrecacheResource("particle", "particles/dark_smoke_test.vpcf", context)
    PrecacheResource("particle", "particles/addons_gameplay/pit_lava_blast.vpcf", context)
    PrecacheResource("particle", "particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact.vpcf", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_music_int.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/music/valve_dota_001/music/game_sounds_music.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_undying.vsndevts", context)
    PrecacheResource("soundfile", "sounds/music/valve_dota_001/music/countdown.vsnd", context)
    PrecacheResource("soundfile", "sounds/physics/damage/npc/tower_projectile.vsnd", context)
    PrecacheResource("soundfile", "sounds/physics/damage/npc/tower_projectile01.vsnd", context)
    PrecacheResource("soundfile", "sounds/physics/damage/npc/tower_projectile02.vsnd", context)
    PrecacheResource("soundfile", "sounds/physics/damage/npc/tower_projectile03.vsnd", context)
    PrecacheResource("soundfile", "sounds/physics/damage/npc/tower_projectile04.vsnd", context)
    PrecacheResource("soundfile", "sounds/weapons/towers/attack_radiant.vsnd", context)
    PrecacheResource("soundfile", "sounds/weapons/towers/attack_dire.vsnd", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_creeps.vsndevts", context)
    PrecacheResource("soundfile", "sounds/misc/creep_deaths/death_gnoll_01.vsnd", context)
    PrecacheResource("soundfile", "sounds/ui/coins_big.vsnd", context)
    PrecacheResource("soundfile", "coins_big.vsnd", context)
    PrecacheResource("soundfile", "General.CoinsBig", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_creeps.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context)
    PrecacheResource("soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context)
    PrecacheResource("soundfile", "sounds/vo/announcer_dlc_pflax/announcer_anc_attack_yr_03.vsnd", context)
    PrecacheResource("sound_folder", "sounds/misc/creep_deaths", context)


    PrecacheResource("model", "models/pets/armadillo/armadillo.vmdl", context)
    PrecacheResource("model", "models/pets/icewrack_wolf/icewrack_wolf.vmdl", context)
    PrecacheResource("model", "models/courier/frog/frog.vmdl", context)
    PrecacheResource("model", "models/items/courier/mei_nei_rabbit/mei_nei_rabbit_flying.vmdl", context)

    PrecacheResource("model", "models/items/courier/pw_zombie/pw_zombie.vmdl", context)
    PrecacheResource("model", "models/courier/gold_mega_greevil/gold_mega_greevil.vmdl", context)
    PrecacheResource("model", "models/creeps/lane_creeps/creep_bad_ranged/lane_dire_ranged.vmdl", context)
    PrecacheResource("model", "models/items/beastmaster/hawk/fotw_eagle/fotw_eagle.vmdl", context)

    PrecacheResource("model", "models/heroes/broodmother/spiderling.vmdl", context)
    PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_gnoll/n_creep_gnoll_frost.vmdl", context)
    PrecacheResource("model", "models/heroes/undying/undying_minion.vmdl", context)
    PrecacheResource("model", "models/courier/octopus/octopus_flying.vmdl", context)

    PrecacheResource("model", "models/heroes/undying/undying_flesh_golem.vmdl", context)
    PrecacheResource("model", "models/heroes/brewmaster/brewmaster_earthspirit.vmdl", context)
    PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_centaur_lrg/n_creep_centaur_lrg.vmdl", context)
    PrecacheResource("model", "models/courier/minipudge/minipudge_flying.vmdl", context)

    PrecacheResource("model", "models/items/beastmaster/boar/fotw_wolf/fotw_wolf.vmdl", context)
    PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_ogre_med/n_creep_ogre_med.vmdl", context)
    PrecacheResource("model", "models/heroes/brewmaster/brewmaster_firespirit.vmdl", context)
    PrecacheResource("model", "models/items/courier/grim_wolf/grim_wolf_flying.vmdl", context)

    PrecacheResource("model", "models/items/warlock/golem/the_torchbearer/the_torchbearer.vmdl", context)
    PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_golem_a/neutral_creep_golem_a.vmdl", context)
    PrecacheResource("model", "models/creeps/baby_rosh_halloween/baby_rosh_dire/baby_rosh_dire.vmdl", context)
    PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_black_dragon/n_creep_black_dragon.vmdl", context)

    PrecacheResource("model", "models/items/warlock/golem/obsidian_golem/obsidian_golem.vmdl", context)
    PrecacheResource("model", "models/creeps/lane_creeps/creep_bad_siege/creep_bad_siege.vmdl", context)
    PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_ghost_a/n_creep_ghost_a.vmdl", context)
    PrecacheResource("model", "models/props_structures/ship_broken001.vmdl", context)

    PrecacheResource("model", "models/creeps/neutral_creeps/n_creep_troll_skeleton/n_creep_skeleton_melee.vmdl", context)

end

-- Create the game mode when we activate
function Activate()
    GameRules.AddonTemplate = MyGemGameMode()
    GameRules.AddonTemplate:InitGameMode()
end

function LoadCustomKV()
    print("Loading KV Data")
    MyGemGameMode.kv = {
        units = assert(LoadKeyValues("scripts/npc/npc_units_custom.txt"))
        --items = LoadKeyValues("scripts/npc/npc_items_custom.txt")
    }
    print(MyGemGameMode.kv.units)
end

function MyGemGameMode:InitGameMode()
    print("Mygemm is loaded.")

    LoadCustomKV()
    local game = GameRules:GetGameModeEntity()

    game:SetAnnouncerDisabled(true)
    game:SetCameraDistanceOverride(1300)
    game:SetThink("OnThink", self, "GlobalThink", 2)
    --game:ClientLoadGridNav()

    Convars:RegisterCommand('tester', function(name)
        PrintTable(_G)
        local player = Convars:GetCommandClient()
        print(player)
        print(player:GetAssignedHero())
        if player.spawner ~= nil then
            player.spawner:GetPrivateScriptScope():SpawnMazeTester()
        end
    end, 'Run maze tester', 0)


    Convars:RegisterCommand('run', function(name, ...)
        local args = { ... }
        local string = table.concat(args, "")
        print(string)
        print(assert(loadstring(string))())
    end, 'Run lua script', 0)

    Convars:RegisterCommand('test', function(name)
        --        local tree1 = Entities:CreateByClassname("MapTree")
        --        local tree2 = Entities:CreateByClassname("CDOTA_MapTree")
        local tree2 = Entities:FindByClassname(nil, "ent_dota_tree")
        local player = Convars:GetCommandClient()
        print(TimeOfDay:IsDay())
        print(TimeOfDay:NightProgress())
        print(EntityUtils:GetClassFieldType(tree2))
        print(EntityLinkClasses)
        print(#EntityLinkClasses)
        PrintTable(EntityLinkClasses)
        PrintTable(getmetatable(EntityLinkClasses))
        tree2:SetAbsOrigin(player:GetAssignedHero():GetAbsOrigin() + Vector(200, 200, 0))
        tree2:SetOrigin(player:GetAssignedHero():GetAbsOrigin() + Vector(200, 200, 0))
        if tree2:IsStanding() then
            print("cutting")
            tree2:CutDown(player:GetTeam())
        else
            print("Growing")
            tree2:GrowBack()
        end
        --        tree2:CutDown(player:GetTeam())
        --        tree2:GrowBack()
        --        EntityFramework:CreateEntity("gem_chipped_ruby")
    end, 'test', 0)

    Convars:RegisterCommand('killall', function(name)
        local player = Convars:GetCommandClient()
        player:GetAssignedHero():ForceKill(true)
        if player.state.KillAll ~= nil then
            player.state:KillAll()
        end
    end, 'Kill all spawned dudes', 0)

    GameRules:SetPreGameTime(10.0)
    GameRules:SetHeroSelectionTime(0.0)
    GameRules:SetGoldPerTick(0)
    game:SetFogOfWarDisabled(true)
    game:SetTopBarTeamValuesVisible(false)
    game:SetAlwaysShowPlayerInventory(true)
    --    game:SetGoldSoundDisabled(true)

    ListenToGameEvent("game_rules_state_change", Dynamic_Wrap(MyGemGameMode, 'OnGameRulesStateChange'), self)
    ListenToGameEvent('player_connect_full', Dynamic_Wrap(MyGemGameMode, 'AutoAssignPlayer'), self)
    ListenToGameEvent('entity_hurt', Dynamic_Wrap(MyGemGameMode, 'OnEntityHurt'), self)
    ListenToGameEvent("entity_killed", Dynamic_Wrap(MyGemGameMode, "OnEntityKilled"), self)
    print("init gamemode")
end

function MyGemGameMode:OnGameRulesStateChange()
    local nNewState = GameRules:State_Get()
    print("OnGameRulesStateChange: " .. nNewState)

    if nNewState == DOTA_GAMERULES_STATE_HERO_SELECTION then
        print("Hero selection")
    end

    if nNewState == DOTA_GAMERULES_STATE_PRE_GAME then
        print("Pre-game")
        local numberOfPlayers = PlayerResource:GetPlayerCount()
    end

    if nNewState == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        print("OnGameRulesStateChange: Game In Progress")
        if not MyGemGameMode.started then
            MyGemGameMode:Start()
        end
    end

    if nNewState >= DOTA_GAMERULES_STATE_POST_GAME then
        print("POST GAME")
    end
end


-- Evaluate the state of the game
function MyGemGameMode:OnThink()
    if GameRules:State_Get() == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
        if not MyGemGameMode.started then
            MyGemGameMode:Start()
        end
    elseif GameRules:State_Get() >= DOTA_GAMERULES_STATE_POST_GAME then
        return nil
    end
    return 1
end

function MyGemGameMode:OnEntityKilled(keys)
    local entityId = keys.entindex_killed
    local entityKilled = EntIndexToHScript(entityId)
    ParticleManager:CreateParticle("particles/units/heroes/hero_bloodseeker/bloodseeker_bloodritual_impact.vpcf", PATTACH_ABSORIGIN, entityKilled)
    EmitSoundOn("Hero_PhantomAssassin.CoupDeGrace", entityKilled)
end

