if Gem == nil then
    Gem = {}
end

Gem.types = {
    "sapphire",
    "ruby",
    "diamond",
    "opal",
    "emerald",
    "aquamarine"
}

Gem.qualities = {
    "chipped",
    "flawed",
    "normal",
    "flawless",
    "perfect"
    -- TODO: "great"
}

Gem.upgradeLevels = {
    {
        100
    },
    {
        80,
        20
    },
    {
        60,
        40
    },
    {
        40,
        60
    },
    {
        20,
        80
    },
    {
        0,
        100
    }
}

function Gem:CreateGem(unitName, position, player, createBlocker)
    local gem = CreateUnitByName(unitName, position, false, player, player, PlayerResource:GetTeam(player:GetPlayerID()))
    CopyFunctions(Gem, gem)
    gem.owner = player
    gem:AddAbility("gem_keep")
    gem:FindAbilityByName("gem_keep"):SetHidden(true)
    gem:FindAbilityByName("gem_keep"):SetLevel(1)
    gem:SetControllableByPlayer(player:GetPlayerID(), true)

    if createBlocker == nil or createBlocker == true then
        print("gem blocker arg was true")
        gem:CreateBlocker()
    end

    local gemData = MyGemGameMode.kv.units[gem:GetUnitName()]
    gem.combinesTo = gemData.CombinesTo
    gem.attacksAir = gemData.AttacksAir
    if player.gems == nil then
        player.gems = {}
    end
    table.insert(player.gems, gem)
    return gem
end

-- Chooses random gem to build according to player's quality level
function Gem:RandomGem(player)
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
    local gemName = "gem_building_" .. quality .. "_" .. type
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
end