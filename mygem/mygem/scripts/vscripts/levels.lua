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
    NewLevel("dude1", 10),
    NewLevel("dude2", 10),
    NewLevel("dude3", 10),
    NewLevel("dude4_air", 10, true),
    NewLevel("dude5", 10),
    NewLevel("dude6", 10),
    NewLevel("dude7", 10),
    NewLevel("dude8_air", 10, true)
}