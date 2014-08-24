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
    NewLevel("dude5", 18),
    NewLevel("dude6", 18),
    NewLevel("dude7", 18),
    NewLevel("dude8_air", 18, true)
}