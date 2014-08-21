--[[
   {
     chipped,
     flawed,
     normal,
     flawless,
     perfect
   }
  ]]




function BuildTest(keys)
    local caster = keys.caster
    local player = caster:GetPlayerOwner()
    local target = keys.target_points[1]
    if player.gems == nil then
        player.gems = {}
    end

    --    local gridX = GridNav:WorldToGridPosX(target.x)
    --    local gridY = GridNav:WorldToGridPosY(target.y)
    --    print("Grid X: " .. gridX)
    --    print("Grid Y: " .. gridY)

    print("Clicked on: " .. target.x .. ":" .. target.y)
    local diffX = target.x % 64
    local diffY = target.y % 64

    if diffX > 32 then
        print("diffx > 32")
        diffX = diffX - 64
    end
    if diffY > 32 then
        print("diffy < 32")
        diffY = diffY - 64
    end

    target.x = target.x - diffX
    target.y = target.y - diffY
    print("New: " .. target.x .. ":" .. target.y)

    local blocker = Entities:FindByName(nil, "tree")
    --    local entityMaker = Entities:FindByName(nil, "entityMaker")
    --    entityMaker:SpawnEntityAtLocation(target, Vector(0,0,0))


    --    local newBlocker = SpawnEntityFromTableSynchronous("ent_dota_tree", {
    --        origin = target,
    --        force_hidden = false,
    --        enabled = true,
    --        model ="models/props_tree/dire_tree003.vmdl",
    --        worldmodel ="models/props_tree/dire_tree003.vmdl",
    --        world_model ="models/props_tree/dire_tree003.vmdl",
    --        body = "1",
    --        skin = "0",
    --        scales ="1 1 1",
    --        scale ="1",
    --        disableshadows = "0",
    --        rendercolor = "255,255,255"
    --    })

    --    newBlocker:SetOriginalModel("models/props_tree/dire_tree003.vmdl")
    --    newBlocker:SetOrigin(target)
    --    newBlocker:SetAbsOrigin(target)
    --    newBlocker:SetModel("models/props_tree/dire_tree003.vmdl")
    --    newBlocker:SetRenderColor(255,255,255)
    --    DoEntFireByInstanceHandle(newBlocker, "CutDown", "1", 1, nil, nil)
    --    DoEntFireByInstanceHandle(newBlocker, "GrowBack", "1", 2, nil, nil)

    --    print(newBlocker:GetAbsOrigin())
    --    local blocker = Entities:CreateByClassname("point_simple_obstruction")
    --    blocker:SetAbsOrigin(target)
    --    blocker:SetOrigin(target)
    --DeepPrintTable(blocker)


    CreateRock(target, player)
end

function Build(keys)
    local caster = keys.caster
    local player = caster:GetPlayerOwner()
    print(player)
    caster:SetGold(100, true)
    local target = keys.target_points[1]

    target.x = target.x - (target.x % 128) + 64
    target.y = target.y - (target.y % 128) + 64


    --    local gridX = GridNav:WorldToGridPosX(target.x)
    --    local gridY = GridNav:WorldToGridPosY(target.y)
    --    print("Grid X: " .. gridX)
    --    print("Grid Y: " .. gridY)

    if player.smallGrid then
        local diffX = target.x % 64
        local diffY = target.y % 64

        if diffX > 32 then
            print("diffx > 32")
            diffX = diffX - 64
        end
        if diffY > 32 then
            print("diffy < 32")
            diffY = diffY - 64
        end

        target.x = target.x - diffX
        target.y = target.y - diffY
    else
        target.x = target.x - (target.x % 128) + 64
        target.y = target.y - (target.y % 128) + 64
    end
    local gem = CreateUnitByName("gem_dummy", target, true, caster, caster, caster:GetTeamNumber())

    if gem:GetOrigin() ~= target then
        print("no space")
        UTIL_Remove(gem)
        return
    else
        UTIL_Remove(gem)
        gem = Gem:CreateGem(Gem:RandomGem(player), target, player)

        local item = keys.ability
        item:SetCurrentCharges(item:GetCurrentCharges() - 1)
    end
end