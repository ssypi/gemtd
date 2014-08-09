local ABILITY_BUILD = "gem_build"
local ITEM_BUILD = "item_place_building"


if Build == nil then
    Build = {}
end


function Build.Begin(player)
    print("Build state started for " .. player:GetPlayerID())
    Build.done = false
    GiveBuildAbility(player)
end

function Build.Update(player)
    if player.done then
        print("Player done building")
        player.done = false
        Build.done = true
    end
    -- TODO: check if we're done and need to change state
end

function Build.End(player)
    print("Build state ended for " .. player:GetPlayerID())
    ClearUnusedGems(player)
    RemoveBuildAbility(player)
    Build.nextState = Running
end

function ClearUnusedGems(player)
    -- TODO: turn all unused gems to mazing rocks
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
        if item ~= nil then
            print("Item name:" .. item:GetName())
            print("Item classname:" .. item:GetClassname())
            hero:RemoveItem(item)
        end
    end
end

