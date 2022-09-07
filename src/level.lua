Level = { 1, 3, 5 }
Level.progressTimerMax = 5
Level.progressTimer = 1
Level.stage = 0
Level.map = { 1, 3, 5 }

function Level.update(dt)
    Level.progressTimer = Level.progressTimer - (1 * dt)
    if Level.progressTimer <= 0 then
        Level.progressTimer = Level.progressTimerMax
        Level.stage = Level.stage + 1
        if Level.stage > #Level.map then
            Level.stage = 1
        end

        local i = 1
        while (i < Level.map[Level.stage]) do
            local randomNumber = math.random(10, love.graphics.getWidth() - 10)
            local newMob = { x = randomNumber, y = -10, img = Mobs.mobImg }
            table.insert(Mobs, newMob)
            i = i + 1
        end
    end
end