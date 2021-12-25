do return (function ()
    
    local Tunnel <const> = module("vrp", "lib/Tunnel")
    local Proxy <const> = module("vrp", "lib/Proxy")

    local vRPclient <const> = Tunnel.getInterface('vRP', 'vRP')
    local vRP <const> = Proxy.getInterface'vRP';

    Tunnel.bindInterface("snCraft", { tryItemCraft = function(item)
            local recipe <const> = item.recipe 
            local itemName <const> = vRP.getItemName{item.name}
            local source <const> = source

            local user_id <const> = vRP.getUserId{source}
            local inventoryData <const> = vRP.getUserDataTable{user_id}.inventory

            vRP.prompt{source, 'Cantitate: ' , '', function(player,craftingAmount)
                if not craftingAmount or craftingAmount == '' then return vRPclient.notify(player,{'~r~Cantitate invalida!',4}) end; 
                craftingAmount = parseInt(craftingAmount); if craftingAmount <= 0 then return vRPclient.notify(player,{'~r~Cantitate invalida!',4}) end; 

                for _ , T in pairs(recipe) do 
                    for invName, v in pairs(inventoryData) do 
                        if T.item == invName then 
                            if not (v.amount*craftingAmount >= T.amount*craftingAmount ) then return vRPclient.notify(source, {'~r~Nu ai destule iteme!',4}) end
                        end
                    end
                end

                for _, T in pairs(recipe) do vRP.tryGetInventoryItem{user_id,T.item, T.amount*craftingAmount, true} end
    
                vRPclient.notify(source, {('Ai craftat ~g~%s ~w~[~g~%s~w~]'):format(itemName,craftingAmount),2})
                vRP.giveInventoryItem{user_id,item.name, craftingAmount, false}
                TriggerClientEvent('snCraft:reopen', source)
           

            end}
        
         
    end})

end)() end
