require("gems/ruby")
require("gems/sapphire")
require("gems/emerald")
require("gems/topaz")
require("gems/opal")
require("gems/diamond")
require("gems/special/malachite")
require("gems/special/silver")
require("gems/special/star")
require("gems/special/jade")

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
    self.combinesTo = gemData.CombinesTo
    self.unitName = gemData.UnitName
    self.fullRadius = gemData.FullAoERadius
    self.halfRadius = gemData.HalfAoERadius
    --self.combinedFrom = gemData.CombinedFrom
    self.attackTargets = gemData.AttackTargets
end

function Gem:CreateGem(unitName, position, player, createBlocker)
    local gem = CreateUnitByName(unitName, position, false, player:GetAssignedHero(), player:GetAssignedHero(), PlayerResource:GetTeam(player:GetPlayerID()))
--    gem:SetOwner(player)
    CopyFunctions(Gem, gem)
    gem.owner = player
    gem:AddAbility("gem_keep")
    local ability = gem:FindAbilityByName("gem_keep")
    ability:SetLevel(1)
    ability:SetHidden(true)

    if not gem:HasModifier("modifier_keep") then
        gem:AddNewModifier(gem, ability, "modifier_keep", {})
    end

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
    return gemName
end

-- Creates a mazing rock and a gridnav blocker for it
function Gem:CreateRock(pos, owner, createBlocker)
    local rock = CreateUnitByName("npc_mygem_building_rock", pos, false, owner, owner, DOTA_TEAM_GOODGUYS)
    CopyFunctions(Gem, rock)
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

function Gem:ReplaceWith(unitName)
    local newGem = Gem:CreateGem(unitName, self:GetAbsOrigin(), self.owner, false)

    if IsValid(self.blocker) then
        newGem.blocker = self.blocker
    else
        newGem:CreateBlocker()
    end
    UTIL_Remove(self)
    return newGem
end

function Gem:ReplaceWithRock()
    local rock = Gem:CreateRock(self:GetAbsOrigin(), self.owner, false)

    print("blocker = ")
    print(self.blocker)
    if IsValid(self.blocker) then
        rock.blocker = self.blocker
    else
        print("blocker is not valid creating new")
        rock:CreateBlocker()
    end
    UTIL_Remove(self)
    return rock
end