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
    if ability:GetLevel() < 8 then
        ability:SetLevel(ability:GetLevel() + 1)
    else
        -- TODO: tell player their upgrade level is maximum
        print("Player#" .. playerId .. " has reached maximum upgrade level")
        ability:SetHidden(true)
        caster:RemoveAbility(ability:GetAbilityName())
    end
end

function GemKeep(keys)
    local gem = keys.caster
    local player = gem.owner
    gem.keep = true
    player.done = true
    CustomGameEventManager:Send_ServerToPlayer(player, "keep_gem", {gemName = gem:GetUnitName()})
end

function GemDelete(keys)
    local gem = keys.caster
    gem:Remove()
end

-- Combine two same gems into a better quality gem of the same type
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
        local newGem = gem:ReplaceWithGem(newName)
        newGem.keep = true
        player.done = true
        CustomGameEventManager:Send_ServerToPlayer(player, "add_combined_gem", {gemName = newGem:GetUnitName()})
    end
end

-- Combine gems into a special recipe gem
function GemCombineSpecial(keys)
    local gem = keys.caster
    local player = gem.owner

    local oneHit = false;
    if gem:HasAbility("gem_keep") then
        print("combining during build")
        local ability = gem:FindAbilityByName("gem_keep")
        ability:SetLevel(1)
        ability:SetHidden(false)
--        gem:CastAbilityImmediately(ability, owner:GetPlayerID())
        oneHit = true;
    else
        print("combining out of build")
    end

    gem.keep = true
    print("Combine special for " .. gem:GetUnitName())

    local newGem;
    local combinesTo = gem.combinesTo
    if not oneHit then
        local allGems = player.allGems
        local tableIndex = FindTableKey(allGems, gem)
        table.remove(allGems, tableIndex)
        local combinedFrom = Gem:GetCombineRecipeFor(combinesTo)
        combinedFrom[gem:GetUnitName()] = nil -- Remove the current gem from the recipe since we already used it
        print("Combining to " .. combinesTo)
        RemoveCombinedGems(player, combinedFrom)
        newGem = gem:ReplaceWithGem(combinesTo)
    else
        newGem = gem:ReplaceWithGem(combinesTo)
        if newGem:HasAbility("gem_keep") then
            print("already has gem keep")
        else
            print("adding gem keep")
            newGem:AddAbility("gem_keep")
        end

        local ability = newGem:FindAbilityByName("gem_keep")
        ability:SetLevel(1)
        ability:SetHidden(false)
        newGem:CastAbilityNoTarget(ability, player:GetPlayerID())
    end
    --local pos = gem:GetAbsOrigin()
    --local team = gem:GetTeam()
    CustomGameEventManager:Send_ServerToPlayer(player, "add_special_gem", {gemName = newGem:GetUnitName()})
end

-- Remove all the gems used in a special combine
function RemoveCombinedGems(player, combinedFrom)
    local allGems = player.allGems
    print("Removing combined gems for player " .. player:GetPlayerID() .. ", count: " .. #combinedFrom)
    for i = #allGems, 1, -1 do
        local gem = allGems[i]
        if IsValid(gem) then
            print("Gem: " .. gem:GetUnitName())
            local inRecipe = combinedFrom[gem:GetUnitName()]
            print(inRecipe)
            if IsValid(gem) and inRecipe ~= nil and inRecipe ~= 0 then
                print("Is part of recipe")
                combinedFrom[gem:GetUnitName()] = 0 -- So we don't remove multiples of the same gem
                gem:ReplaceWithRock()
                table.remove(allGems, i)
            end
        end
    end
end