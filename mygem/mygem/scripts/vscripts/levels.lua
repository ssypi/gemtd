if Levels == nil then
    Levels = {}
end


function NewLevel(unit, amount, isAir)
    amount = amount or 10
    isAir = isAir or false
    return {
        unit = unit,
        count = amount,
        isAir = isAir
    }
end

Levels = {
    NewLevel("dude1", 5),
    NewLevel("dude2", 8),
    NewLevel("dude3", 8),
    NewLevel("dude4_air", 8, true),
    NewLevel("dude1", 10),
    NewLevel("dude2", 16),
    NewLevel("dude3", 16),
    NewLevel("dude4_air", 16, true)
}