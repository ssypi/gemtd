function BuyHp(keys)
    local caster = keys.caster
    local player = caster:GetPlayerOwner()
    local hero = player:GetAssignedHero()
    if caster:GetHealthDeficit() > 0 then
        --        caster:SetHealth(caster:GetHealth()+1)
        caster:Heal(1, caster)
    else
        player:ShowError("Already at full health!")
        hero:SetGold(hero:GetGold() + 10)
    end
end

function OnAbilityPhaseStart(keys)
    print("Ability phase started")
    PrintTable(keys)
end

function ToggleGridOn(keys)
    local caster = keys.caster
    local player = PlayerResource:GetPlayer(caster:GetPlayerID())
    player.smallGrid = true
    print("Small grid on")
end

function ToggleGridOff(keys)
    local caster = keys.caster
    local player = PlayerResource:GetPlayer(caster:GetPlayerID())
    player.smallGrid = false
    print("Small grid off")
end

function UpgradeQuality(keys)

    local caster = keys.caster
    local playerId = keys.caster:GetPlayerID()
    local player = PlayerResource:GetPlayer(playerId)
    print("upg qual")
    print(player)
    print(player.upgradeQuality)
    if player.upgradeQuality ~= nil then
        player.upgradeQuality = player.upgradeQuality + 1
    else
        player.upgradeQuality = 2
    end
    print(player.upgradeQuality)
    local ability = keys.ability
    if ability:GetLevel() < 5 then
        ability:SetLevel(ability:GetLevel() + 1)
    else
        ability:SetHidden(true)
        caster:RemoveAbility(ability:GetAbilityName())
    end
end

function GemKeep(keys)
    local gem = keys.caster
    local player = gem.owner
    gem.keep = true
    player.done = true
    print("Sending custom game event message")
    local data = {
    }
    local gemName = "GemName"
    data[gemName] = gem:GetUnitName()
    print("Gem unit name: " .. data[gemName])
    CustomGameEventManager:Send_ServerToPlayer(player, "keep_gem", data)
end

function GemDelete(keys)
    local gem = keys.caster
    gem:Remove()
end

-- Combine two same placedGems into a better quality gem of the same type
function GemCombine(keys)
    local gem = keys.caster
    local player = gem.owner
    gem.keep = true
    print("Combining gem " .. gem:GetUnitName())
    local unitName = gem:GetUnitName()
    local quality, type = unitName:match("gem_(.+)_(.+)")
    local qualityNum = FindTableKey(Gem.qualities, quality)
    if qualityNum < #Gem.qualities then
        local newName = "gem_" .. Gem.qualities[qualityNum + 1] .. "_" .. type
        local newGem = gem:ReplaceWith(newName)
        newGem.keep = true
        player.done = true
        local combinedGem = {
        }
        local gemName = "GemName"
        combinedGem[gemName] = newGem:GetUnitName()
        CustomGameEventManager:Send_ServerToPlayer(player, "add_combined_gem", combinedGem)
    end
end

-- Combine placedGems into a special recipe gem
function GemCombineSpecial(keys)
    local gem = keys.caster
    local player = gem.owner
    gem.keep = true
    print("Combine special for " .. gem:GetUnitName())

    local gemToBeRemoved = {
    }
    local gemName = "GemName"
    gemToBeRemoved[gemName] = gem:GetUnitName()
    CustomGameEventManager:Send_ServerToPlayer(player, "remove_gem", gemToBeRemoved)

    local allGems = player.allGems
    local tableIndex = FindTableKey(allGems, gem)
    table.remove(allGems, tableIndex)
    local pos = gem:GetAbsOrigin()
    local team = gem:GetTeam()
    local combinesTo = gem.combinesTo
    local combinedFrom = Gem:GetCombineRecipeFor(combinesTo)
    combinedFrom[gem:GetUnitName()] = nil -- Remove the current gem from the recipe since we already used it

    print("Combining to " .. combinesTo)
    RemoveCombinedGems(player, combinedFrom)
    local newGem = gem:ReplaceWith(combinesTo)

    local specialGem = {
    }
    local gemName = "GemName"
    specialGem[gemName] = newGem:GetUnitName()
    CustomGameEventManager:Send_ServerToPlayer(player, "add_special_gem", specialGem)
end

-- Remove all the placedGems used in a special combine
function RemoveCombinedGems(player, combinedFrom)
    local allGems = player.allGems
    for i = #allGems, 1, -1 do
        local gem = allGems[i]
        if IsValid(gem) and combinedFrom[gem:GetUnitName()] then
            combinedFrom[gem:GetUnitName()] = 0 -- So we don't remove multiples of the same gem

            local data = {
            }
            local gemName = "GemName"
            data[gemName] = gem:GetUnitName()
            CustomGameEventManager:Send_ServerToPlayer(player, "remove_gem", data)

            gem:ReplaceWithRock()
            table.remove(allGems, i)
        end
    end
end