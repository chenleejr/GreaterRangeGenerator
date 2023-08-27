local function CustomizeGenerator()
    local radius = SandboxVars.CustomizableGenerator.Radius
    local levelDistance = SandboxVars.CustomizableGenerator.LevelDistance
    local maxFuel = SandboxVars.CustomizableGenerator.MaxFuel
    --this constructor does nothing but create a object,
    --it won't add the generator to map and won't sync it to other clients, so we don't need to remove the object here
    local generator = IsoGenerator.new(nil)
    generator:setDefaultRadius(radius)
    generator:setDefaultLevelDistance(levelDistance)
    generator:setDefaultMaxFuel(maxFuel)
end

Events.OnGameStart.Add(CustomizeGenerator)