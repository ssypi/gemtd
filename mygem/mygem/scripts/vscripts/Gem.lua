require("gems/amethyst")
require("gems/aquamarine")
require("gems/diamond")
require("gems/emerald")
require("gems/opal")
require("gems/ruby")
require("gems/sapphire")
require("gems/topaz")

require("gems/special/malachite")
require("gems/special/silver")
require("gems/special/star")
require("gems/special/jade")
require("gems/special/gold")

if Gem == nil then
    Gem = {}
end

Gem.types = {
    "sapphire",
    "ruby",
    "diamond",
    "topaz",
    "amethyst",
    "opal",
    "emerald",
    "aquamarine"
}

Gem.qualities = {
    "chipped",
    "flawed",
    "normal",
    "flawless",
    "perfect",
    "great"
}


-- cost: 20, 50, 80, 110, 140, 170, 200, 230
Gem.upgradeLevels = {
    { 100 },
    { 70, 30 },
    { 60, 30, 10 },
    { 50, 30, 20 },
    { 40, 30, 20, 10 },
    { 30, 30, 30, 10 },
    { 20, 30, 30, 20 },
    { 10, 30, 30, 30 },
    { 0, 30, 30, 30, 10 }
}

function Gem:InitCustomKvData()
    local gemData = MyGemGameMode.kv.units[self:GetUnitName()]
    if gemData.Custom ~= nil then
        gemData = gemData.Custom
    end
    self.combinesTo = gemData.CombinesTo
    self.unitName = gemData.UnitName
    self.fullRadius = gemData.FullAoERadius
    self.halfRadius = gemData.HalfAoERadius
    --self.combinedFrom = gemData.CombinedFrom
    self.attackTargets = gemData.AttackTargets
    self.upgradesTo = gemData.UpgradesTo
end

function Gem:AddKeep()
    local gem = self
    gem:AddAbility("gem_keep")
    local ability = gem:FindAbilityByName("gem_keep")
    ability:SetLevel(1)
    ability:SetHidden(true)

    if not gem:HasModifier("modifier_keep") then
        gem:AddNewModifier(gem, ability, "modifier_keep", {})
    end
end

function Gem:CreateGem(unitName, position, player, createBlocker)
    local gem = CreateUnitByName(unitName, position, false, player:GetAssignedHero(), player:GetAssignedHero(), PlayerResource:GetTeam(player:GetPlayerID()))
--    gem:SetOwner(player)
    CopyFunctions(Gem, gem)
    gem.owner = player

    gem:SetControllableByPlayer(player:GetPlayerID(), true)

    if createBlocker == nil or createBlocker == true then
        gem:CreateBlocker()
    end

    gem:InitCustomKvData()
--    local unitName = gem.unitName:gsub("%s+", "")
    local quality, type = gem:GetUnitName():match("gem_(.+)_(.+)")
    print("Qual:" .. quality)
    print("Type:" .. type)
    gem.quality = quality
    gem.qualityNum = vlua.find(Gem.qualities, quality)
    gem.type = type
    local class = type:gsub("^%l", string.upper)
    if vlua.find(gem:GetUnitName(), "star") ~= nil then
        class = "Star"
    end
    print("Class: " .. class)
    print(quality)
    print(type)
    if _G[class] ~= nil then
        CopyFunctions(_G[class], gem)
    end

    gem:AddAbility("gem_script_proxy")
    ability = gem:FindAbilityByName("gem_script_proxy")
    ability:SetLevel(1)

    --    if _G[unitName] ~= nil then
    --        CopyFunctions(_G[unitName], gem)
--    end

    if player.gems == nil then
        player.gems = {}
    end
    table.insert(player.gems, gem)
    return gem
end

-- Chooses random gem to build according to player's quality level
function Gem:RandomGem(player)
    if player.forceNextGem ~= nil then
        local nextGem = player.forceNextGem
        player.forceNextGem = nil
        CustomGameEventManager:Send_ServerToPlayer(player, "place_gem", {gemName=nextGem})
        return nextGem
    end
    if player.upgradeQuality == nil then
        print("Upgradelevel nil")
        player.upgradeQuality = 1
    end
    print("UpgradeLevel: " .. player.upgradeQuality)
    local level = Gem.upgradeLevels[player.upgradeQuality]
    local type = Gem.types[RandomInt(1, #Gem.types)]
    local number = RandomInt(1, 100)
    local quality = "chipped"

    for i = 1, #level do
        if number <= level[i] then
            print("quality for " .. number .. " is: " .. i .. " = " .. Gem.qualities[i])
            quality = Gem.qualities[i]
        end
    end
    print(quality)
    local gemName = "gem_" .. quality .. "_" .. type
    print("Random gem name: " .. gemName)
    CustomGameEventManager:Send_ServerToPlayer(player, "place_gem", {gemName=gemName})
    return gemName
end

-- Creates a mazing rock and a gridnav blocker for it
function Gem:CreateRock(pos, owner, createBlocker)
    local rock = CreateUnitByName("npc_mygem_building_rock", pos, false, owner, owner, owner:GetTeam())
    CopyFunctions(Gem, rock)
    if rock:HasModifier("modifier_invulnerable") then
        rock:RemoveModifierByName("modifier_invulnerable")
    end
    rock:SetControllableByPlayer(owner:GetPlayerID(), true)
    if createBlocker == nil or createBlocker == true then
        print("blocker arg was true")
        rock:CreateBlocker()
    end
    return rock
end

function Gem:DisableIfAirOnly()
    if IsValid(self) and self.attackTargets == "GEM_ATTACK_AIR" then
        self:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
        print("Disabling " .. self:GetUnitName())
    end
end

function Gem:DisableIfGroundOnly()
    if IsValid(self) and self.attackTargets == "GEM_ATTACK_GROUND" then
        self:SetAttackCapability(DOTA_UNIT_CAP_NO_ATTACK)
        print("Disabling " .. self:GetUnitName())
    end
end

function Gem:Enable()
    if IsValid(self) then
        self:SetAttackCapability(DOTA_UNIT_CAP_RANGED_ATTACK)
    end
end

function Gem:CreateBlocker()
    print("Creating blocker")
    local gridNavBlocker = SpawnEntityFromTableSynchronous("point_simple_obstruction", {
        origin = self:GetAbsOrigin()
    })
    if gridNavBlocker == nil then
        print("Error, unable to create blocker")
    end
    self.blocker = gridNavBlocker
    return gridNavBlocker
end

function Gem:GetCombineRecipeFor(specialName)
    local combineTable = CopyTableShallow(MyGemGameMode.kv.units[specialName].CombinedFrom)
    return combineTable
end

function Gem:Remove()
    print("Removing rock")
    if self.blocker ~= nil then
        print("Removing blocker")
        DoEntFireByInstanceHandle(self.blocker, "Disable", "1", 0, nil, nil)
        DoEntFireByInstanceHandle(self.blocker, "Kill", "1", 1, nil, nil)
        --        UTIL_Remove(self.blocker)
    else
        print("Gem has no blocker?")
    end
    UTIL_Remove(self)
end

local function ReplaceWith(original, replacement)
    print("replacing " .. original:GetUnitName() .. " with " .. replacement:GetUnitName())
    if replacement ~= nil then
        CustomGameEventManager:Send_ServerToPlayer(original.owner, "remove_gem", {gemName = original:GetUnitName()})
        if IsValid(original.blocker) then
            replacement.blocker = original.blocker
        else
            replacement:CreateBlocker()
        end
        replacement.kills = original.kills
        UTIL_Remove(original)
        return replacement
    else
        error("Error replacing " .. original:GetUnitName() .. " with.. ")
        error(replacement)
    end
end

function Gem:ReplaceWithGem(gemName)
    local newGem = Gem:CreateGem(gemName, self:GetAbsOrigin(), self.owner, false)
    return ReplaceWith(self, newGem)
end


function Gem:ReplaceWithRock()
    local rock = Gem:CreateRock(self:GetAbsOrigin(), self.owner, false)
    return ReplaceWith(self, rock)
end