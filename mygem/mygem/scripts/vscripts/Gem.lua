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

function Gem:CreateGem(unitName, position, player)
    local gem = CreateUnitByName(unitName, position, false, player, player, PlayerResource:GetTeam(player:GetPlayerID()))
    gem.owner = player
    gem:AddAbility("gem_keep")
    gem:FindAbilityByName("gem_keep"):SetHidden(true)
    gem:FindAbilityByName("gem_keep"):SetLevel(1)
    gem:SetControllableByPlayer(player:GetPlayerID(), true)

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
