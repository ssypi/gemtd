require("levels")

local ABILITY_BUILD = "gem_build"
local ITEM_BUILD = "item_place_building"
local GEMS_PER_ROUND = 5



if Build == nil then
    Build = {}
end


function Build.Begin(player)
    print("Build state started for " .. player:GetPlayerID())
    Build.done = false
    GiveBuildAbility(player)
end

function CalculateTotal(combinedFrom)
    local total = 0
    for _,v in pairs(combinedFrom) do
        total = total + v
    end
    return total
end

function CheckForCombineSpecial(player)
    local allGems = player.allGems
    local gem = allGems[#allGems]
    local combinesTo = gem.combinesTo
    if combinesTo ~= nil then
        local combinedFrom = MyGemGameMode.kv.units[combinesTo].CombinedFrom
        print("Combined from:")
        PrintTable(combinedFrom)
        for _,currentGem in pairs(allGems) do
            local gemName = currentGem:GetUnitName()
            print(gemName)
            if combinedFrom[gemName] then
                print("Found combine")
                combinedFrom[gemName] = combinedFrom[gemName] - combinedFrom[gemName]
            end
        end

        if CalculateTotal(combinedFrom) <= 0 then
            print("Have special combine!")
            AddSpecialCombine(gem)
        end
    end
end

function AddSpecialCombine(gem)
    if not gem:HasAbility("gem_combine_special") then
        gem:AddAbility("gem_combine_special")
        gem:FindAbilityByName("gem_combine_special"):SetLevel(1)
    end

    -- TODO: Add special combine ability/particle
end

function CheckForCombine(player, gem)
    local gems = player.gems
    for i=1, #gems do
        if gems[i] ~= gem and gems[i]:GetUnitName() == gem:GetUnitName() then
            if not gems[i]:HasAbility("gem_combine") then
                gems[i]:AddAbility("gem_combine")
                gems[i]:FindAbilityByName("gem_combine"):SetLevel(1)
            end
        end
    end
end

function Build.Update(player)
    if player.done then
        print("Player done building")
        player.done = false
        Build.done = true
    end

    -- TODO: no need to do this on every update call
    if #player.gems >= GEMS_PER_ROUND then
        for i=1, #player.gems do
            local gem = player.gems[i]
            CheckForCombine(player, gem)
            if not gem:HasAbility("gem_keep") then
                gem:AddAbility("gem_keep")
                gem:FindAbilityByName("gem_keep"):SetLevel(1)
            end
        end
        RemoveBuildAbility(player)
    end
end

function Build.End(player)
    print("Build state ended for " .. player:GetPlayerID())
    ClearUnusedGems(player)
    RemoveBuildAbility(player)
    CheckForCombineSpecial(player)
    Build.nextState = Running
end

function ClearGemAbilities(gem)
    if gem:HasAbility("gem_keep") then
        gem:RemoveAbility("gem_keep")
    end
    if gem:HasAbility("gem_combine") then
        gem:RemoveAbility("gem_combine")
    end
end

function ClearUnusedGems(player)
    local gems = player.gems

    print("Gem amount: " .. #gems)
    for i = #gems, 1, -1 do
        local gem = gems[i]
        if gem.keep then
            table.insert(player.allGems, gem)
            ClearGemAbilities(gems[i])
        else
            local pos = gem:GetOrigin()
            UTIL_Remove(gem)
            CreateRock(pos, gem.owner)
            --table.remove(gems, i)
        end
    end
    player.gems = {}
end

function GiveBuildAbility(player)
    local hero = player:GetAssignedHero()
    if hero:HasItemInInventory(ITEM_BUILD) then
        print("Already has build item")
        RemoveBuildAbility(player)
    end
    local buildItem = CreateItem(ITEM_BUILD, player, player)
    hero:AddItem(buildItem)

--    if hero:HasAbility(ABILITY_BUILD) then
--        hero:RemoveAbility(ABILITY_BUILD)
--    end
--    hero:AddAbility(ABILITY_BUILD)
    hero.gems = {} -- clear gems already built this level
end

function RemoveBuildAbility(player)
    local hero = player:GetAssignedHero()
--    if hero:HasAbility(ABILITY_BUILD) then
--        hero:RemoveAbility(ABILITY_BUILD)
--    end
    for i=0, 5 do
        local item = hero:GetItemInSlot(i)
        if item ~= nil and item:GetName() == ITEM_BUILD then
            hero:RemoveItem(item)
        end
    end
end

