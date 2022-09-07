Level = { 1, 3, 5 }
LevelProgressTimerMax = 5
LevelProgressTimer = 1
LevelStage = 0

function updateLevel(dt)
    LevelProgressTimer = LevelProgressTimer - (1 * dt)
    if LevelProgressTimer <= 0 then
        LevelProgressTimer = LevelProgressTimerMax
        LevelStage = LevelStage + 1
        if LevelStage > #Level then
            LevelStage = 1
        end

        local i = 1
        while (i < Level[LevelStage]) do
            local randomNumber = math.random(10, love.graphics.getWidth() - 10)
            local newMob = { x = randomNumber, y = -10, img = MobImg }
            table.insert(Mobs, newMob)
            i = i + 1
        end
    end
end