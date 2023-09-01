KCISWorldObjectContextMenuPatch = {}

function KCISWorldObjectContextMenuPatch.OnFillWorldObjectContextMenu(player, context, worldobjects, test)
    local generator = nil
    for _, worldobject in ipairs(worldobjects) do
        local square = worldobject:getSquare()
        if square then
            for i=0,square:getObjects():size() - 1 do
                local object = square:getObjects():get(i)
                if instanceof(object, "IsoGenerator") then
                    generator = object
                end
            end
        end
    end

    local playerObj = getSpecificPlayer(player)
    local playerInv = playerObj:getInventory()

    local function predicatePetrol(item)
        return (item:hasTag("Petrol") or item:getType() == "PetrolCan") and (item:getDrainableUsesInt() > 0)
    end

    local maxFuel = CustomizableGenerator.SafeGetMaxFuel(generator)
    if generator and not generator:isActivated() and generator:getFuel() < maxFuel and playerInv:containsEvalRecurse(predicatePetrol) then
        local petrolCan = playerInv:getFirstEvalRecurse(predicatePetrol);
        -- context:addOption(getText("ContextMenu_GeneratorAddFuel"), worldobjects, ISWorldObjectContextMenu.onAddFuelGenerator, petrolCan, generator, player, context);
        context:removeOptionByName(getText("ContextMenu_GeneratorAddFuel"))
        ISWorldObjectContextMenu.onAddFuelGenerator(worldobjects, petrolCan, generator, player, context)
    end
end

ISWorldObjectContextMenu.doAddFuelGenerator = function(worldobjects, generator, fuelContainerList, fuelContainer, player)
    print("Size : " .. tostring(fuelContainerList))
    local playerObj = getSpecificPlayer(player)
    if not fuelContainerList then
        fuelContainerList = {};
        table.insert(fuelContainerList, fuelContainer);
    end
    local maxFuel = CustomizableGenerator.SafeGetMaxFuel(generator)
    if luautils.walkAdj(playerObj, generator:getSquare()) then
        for i,item in ipairs(fuelContainerList) do
            if generator:getFuel() < maxFuel then
                ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), item, true, false);
                ISTimedActionQueue.add(ISAddFuel:new(player, generator, item, 70 + (item:getUsedDelta() * 40)));
            end
        end
    end
end

Events.OnFillWorldObjectContextMenu.Add(KCISWorldObjectContextMenuPatch.OnFillWorldObjectContextMenu)
