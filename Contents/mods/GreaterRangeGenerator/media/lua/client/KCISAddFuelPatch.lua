function ISAddFuel:perform()
    self.character:stopOrTriggerSound(self.sound)

    local endFuel = 0;
    local maxFuel = CustomizableGenerator.SafeGetMaxFuel(self.generator)
    while self.petrol and self.petrol:getUsedDelta() > 0 and self.generator:getFuel() + endFuel < maxFuel do
        self.petrol:Use();
        endFuel = endFuel + 10;
    end

    self.generator:setFuel(self.generator:getFuel() + endFuel)

    -- needed to remove from queue / start next.
    ISBaseTimedAction.perform(self);
end