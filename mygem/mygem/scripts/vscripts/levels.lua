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
    NewLevel("dude4", 10, true),
    NewLevel("dude5", 10),
    NewLevel("dude6", 10),
    NewLevel("dude7", 10),
    NewLevel("dude8", 10, true),
    NewLevel("dude9", 10),
    NewLevel("dude10", 10),
    NewLevel("dude11", 10),
    NewLevel("dude12", 10, true),
    NewLevel("dude13", 10),
    NewLevel("dude14", 10),
    NewLevel("dude15", 10),
    NewLevel("dude16", 10, true),
    NewLevel("dude17", 10),
    NewLevel("dude18", 10),
    NewLevel("dude19", 10),
    NewLevel("dude20", 10, true),
    NewLevel("dude21", 10),
    NewLevel("dude22", 10),
    NewLevel("dude23", 10),
    NewLevel("dude24", 10, true),
    NewLevel("dude25", 10),
    NewLevel("dude26", 10),
    NewLevel("dude27", 10),
    NewLevel("dude28", 10, true),
    NewLevel("dude29", 10),
    NewLevel("dude30", 10),
}