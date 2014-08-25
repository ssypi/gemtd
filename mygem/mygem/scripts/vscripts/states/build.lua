require("levels")

local ABILITY_BUILD = "gem_build"
local ITEM_BUILD = "item_place_gem"
local GEMS_PER_ROUND = 5

Build = {}
Build.__index = Build

function Build.new(player)
    local buildState = {}
    setmetatable(buildState, Build)
    buildState.player = player
    return buildState
end


function Build:Begin()
    local player = self.player
    print("Build state started for " .. player:GetPlayerID())
    self.done = false
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
        local combinedFrom = Gem:GetCombineRecipeFor(combinesTo)
        print("Combined from:")
        PrintTable(combinedFrom)
        for _,currentGem in pairs(allGems) do
            if IsValid(currentGem) then
                local gemName = currentGem:GetUnitName()
                print(gemName)
                if combinedFrom[gemName] ~= nil and combinedFrom[gemName] > 0 then
                    print("Found combine")
                    combinedFrom[gemName] = combinedFrom[gemName] - combinedFrom[gemName]
                end
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
end

function CheckForCombine(player, gem)
    if not IsValid(gem) then
        return
    end
    local gems = player.gems
    for i=1, #gems do
        if IsValid(gems[i]) and gems[i] ~= gem and gems[i]:GetUnitName() == gem:GetUnitName() then
            if not gems[i]:HasAbility("gem_combine") then
                gems[i]:AddAbility("gem_combine")
                gems[i]:FindAbilityByName("gem_combine"):SetLevel(1)
            end
        end
    end
end

function Build:Update()
    local player = self.player
    if player.done then
        print("Player done building")
        player.done = false
        self.done = true
    end

    -- TODO: no need to do this on every update call
    if #player.gems >= GEMS_PER_ROUND then
        for i=1, #player.gems do
            local gem = player.gems[i]
            if IsValid(gem) then
                CheckForCombine(player, gem)
                if gem:HasAbility("gem_keep") then
                    gem:FindAbilityByName("gem_keep"):SetLevel(1)
                    gem:FindAbilityByName("gem_keep"):SetHidden(false)
                end
            end
        end
        RemoveBuildAbility(player)
    end
end

function Build:End()
    local player = self.player
    print("Build state ended for " .. player:GetPlayerID())
    ClearUnusedGems(player)
    RemoveBuildAbility(player)
    CheckForCombineSpecial(player)
    self.nextState = Running.new(player)
end

function ClearGemAbilities(gem)
    if not IsValid(gem) then
        return
    end
    if gem:HasAbility("gem_keep") then
        local ability = gem:FindAbilityByName("gem_keep")
        gem:RemoveAbility("gem_keep")
    end
    if gem:HasAbility("gem_combine") then
        local ability = gem:FindAbilityByName("gem_combine")
        gem:RemoveAbility("gem_combine")
    end
    if gem:HasModifier("modifier_keep") then
        gem:RemoveModifierByName("modifier_keep")
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
            gem:ReplaceWithRock()
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
    player.gems = {} -- clear gems already built this level
end

function RemoveBuildAbility(player)
    local hero = player:GetAssignedHero()
    for i=0, 5 do
        local item = hero:GetItemInSlot(i)
        if item ~= nil and item:GetName() == ITEM_BUILD then
            hero:RemoveItem(item)
        end
    end
end

