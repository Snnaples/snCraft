do return (function()
            
    ::snCraft:: 
    local inside = false;

    local drawInsideText <const> = function(text, x, y, scale, r, g, b)
        SetTextFont(2)
        SetTextCentre(1)
        SetTextProportional(0)
        SetTextScale(scale, scale)
        SetTextDropShadow(30, 5, 5, 5, 255)
        SetTextEntry"STRING"
        SetTextColour(r, g, b, 255)
        AddTextComponentString(text)
        DrawText(x, y)
    end


    local function removeFunctionRefs(t)
        local cfg = {} 
        for key,value in pairs(t) do 
            if type(value) ~= 'function'  then 
                cfg[key] = value 
            end
        end
        return cfg
    end


    local vRP <const> = Proxy.getInterface[[vRP]]

    local Citizen <const> = Citizen

    local SendNUI <const> = SendNUIMessage
    
    local remoteServerCraft <const> = Tunnel.getInterface('snCraft','snCraft')

    local getItemRecipe <const> = function(name)
        local t = {}
        for k,v in pairs(CraftConfig.items) do 
            if k == name then 
                for key,value in pairs(v) do 
                    if key ~= 'name' then 
                        table.insert(t, { item = key, amount = value })
                    end
                end
            end
        end
        return t 
    end

    local sendConfigToNUI <const> = function()  SendNUI{type = 'loadConfig', config = removeFunctionRefs(CraftConfig)} end
    AddEventHandler('playerSpawned',sendConfigToNUI)
    AddEventHandler('snCraft:handleInsideState', function(boolean) inside = boolean end)
    
    local function insideStateHandler (boolean)  TriggerEvent('snCraft:handleInsideState',boolean) end
    function CraftConfig.leaveNUICallback()
        insideStateHandler(false)
        SetNuiFocus(false,false)
        
    end; RegisterNUICallback("close", CraftConfig.leaveNUICallback)

    RegisterNUICallback('closeWithItemSelection', function(t)
         insideStateHandler(false)
         SetNuiFocus(false,false)
        remoteServerCraft.tryItemCraft{ { name = t.name, recipe = getItemRecipe(t.name) }  }
    end)
    RegisterNetEvent('snCraft:reopen', function() CraftConfig.insideCallback"open"; insideStateHandler(true); SetNuiFocus(true,true) end)


    vRP.addBlip{CraftConfig.location.x,CraftConfig.location.y,CraftConfig.location.z, CraftConfig.blipSprite, CraftConfig.blipColor, CraftConfig.blipText}

    local initThreadHandler <const> = function()
        while true do 
            ::breakloop::
            if not inside then 
                local coords <const> = GetEntityCoords(PlayerPedId())
                if #(coords - CraftConfig.location) <= 5.0 then
                    local p <const> = PlayerPedId()
                    while #(GetEntityCoords(p)  - CraftConfig.location) <= 5.0 do 
                        Citizen.Wait(2)
                        drawInsideText(CraftConfig.insideText, 0.5, 0.85, 0.4, 255, 255, 255)
                        if IsControlJustPressed(1,51) then 
                            inside = true
                            sendConfigToNUI()
                            SetNuiFocus(inside,inside)
                            CraftConfig.insideCallback"open" 
                            goto breakloop
                        end
                    end
                end
            end
            Citizen.Wait(1500)
        end
    end

    Citizen.CreateThread(initThreadHandler)

end)() end
