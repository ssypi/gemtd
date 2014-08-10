function GemKeep(keys)
    local gem = keys.caster
    local player = gem.owner
    local gems = player.gems

    print("Gem amount: " ..  #gems)
    for i = #gems, 1, -1 do
        if gems[i]:HasAbility("gem_keep") then
            gems[i]:RemoveAbility("gem_keep")
        end
        if gems[i] ~= gem then
            local pos = gems[i]:GetOrigin()
            UTIL_Remove(gems[i])
            CreateRock(pos, gem.owner)
            --table.remove(gems, i)
        end
    end
    player.gems = {}
    player.done = true
end

function GemDelete(keys)
    local gem = keys.caster
    UTIL_Remove(gem)
end