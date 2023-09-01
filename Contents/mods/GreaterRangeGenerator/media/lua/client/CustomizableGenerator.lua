local function CustomizeGenerator()
    local radius = SandboxVars.CustomizableGenerator.Radius
    local levelDistance = SandboxVars.CustomizableGenerator.LevelDistance
    local maxFuel = SandboxVars.CustomizableGenerator.MaxFuel
    --this constructor does nothing but create a object,
    --it won't add the generator to map and won't sync it to other clients, so we don't need to remove the object here
    local generator = IsoGenerator.new(nil)
    if generator.getMaxFuel ~= nil then CustomizableGenerator.Version = 2 end

    if CustomizableGenerator.Version == 1 then
        return
    end
    generator:setDefaultRadius(radius)
    generator:setDefaultLevelDistance(levelDistance)
    generator:setDefaultMaxFuel(maxFuel)
end

CustomizableGenerator = {}
CustomizableGenerator.Version = 1

function CustomizableGenerator.SafeGetMaxFuel(generator)
    if CustomizableGenerator.Version == 1 then
        return 100
    end
    return generator:getMaxFuel()
end

Events.OnGameStart.Add(CustomizeGenerator)