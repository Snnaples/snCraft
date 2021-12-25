CraftConfig = {}

CraftConfig.location = vec(-857.1297, -415.556, 36.62634)
CraftConfig.blipSprite = 214
CraftConfig.blipColor = 30
CraftConfig.blipText = 'Crafting'
CraftConfig.insideText = 'Apasa ~b~E~w~ pentru a deschide ~b~Crafting'


--[[
    ['nume_item'] = {
        name = 'Nume in UI',
        ['nume_ingredient'] =  cantitate ingredient
    }
]]

CraftConfig.items = {
    ['dirty_money'] = {
        name = "Bani murdari",
        ['tacos'] = 2  
    },

    ['secure_card'] = {
       name =  "Card de securitate",
        ['secure_card'] = 1
    },
    ['water'] = {
        name = "Apa",
        ['secure_card'] = 1
    }
}

-- permisiuni?
local SendNUI <const> = SendNUIMessage
function CraftConfig.insideCallback(p)
    SendNUI{type = p}
end 








