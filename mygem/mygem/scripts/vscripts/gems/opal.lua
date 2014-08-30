Opal = {
    aura = {
        radius = {200, 300, 400, 500, 600, 1000},
        bonus = {20, 25, 30, 35, 50, 100}
    }
}

function Opal:OnCreated(keys)
    print("Opal created")
    --TODO: fix not getting called
    --TODO: add aura, level up
end

function Opal:OnAttackLanded(keys)
end

function Opal:OnAttackStart(keys)
end