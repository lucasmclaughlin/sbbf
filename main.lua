debug = true

-- Collision detection taken function from http://love2d.org/wiki/BoundingBox.lua
-- Returns true if two boxes overlap, false if they don't
-- x1,y1 are the left-top coords of the first box, while w1,h1 are its width and height
-- x2,y2,w2 & h2 are the same, but for the second box
function CheckCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and
        x2 < x1 + w1 and
        y1 < y2 + h2 and
        y2 < y1 + h1
end

-- function ComboAdd(key)

-- end

IsAlive = true
Score = 0
Player = { x = 200, y = 710, speed = 400, img = nil }

-- Track key inputs for key combos, probably goes in some other file
-- combo class or something?
Keys = { 'w', 'a', 's', 'd', 'h', 'j', 'k', 'l' }
KeyTimerMax = .7
KeyTimer = KeyTimerMax
KeyList = {}

-- Very simple level will loop through this and repeat until you die currently
Level = { 1, 3, 5 }
LevelProgressTimerMax = 5
LevelProgressTimer = 1
LevelStage = 0

MobImg = nil
Mobs = {}

AttackBoxes = {}

function love.load(arg)
    BulletImg = love.graphics.newImage('assets/bullet.png')
    Player.img = love.graphics.newImage('assets/ship.png')
    MobImg = love.graphics.newImage('assets/enemy.png')
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    for i, input in ipairs(Keys) do
        if key == input then
            table.insert(KeyList, #KeyList + 1, input)
        end
        if KeyList[i] == KeyList[i - 1] then
            table.remove(KeyList, i)
        end
    end

    -- ComboAdd(key)
end

function love.update(dt)
    -- Removes old keystrokes from KeyList
    KeyTimer = KeyTimer - dt
    if KeyTimer < 0 then
        table.remove(KeyList, 1)
        KeyTimer = KeyTimerMax
    end

    -- loops through Level and spawns enemies as

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

    -- update the positions of enemies, removes mobs that have gone past bottom of screen
    if Mobs then
        for i, mob in ipairs(Mobs) do
            mob.y = mob.y + (200 * dt)

            if mob.y > 850 then
                table.remove(Mobs, i)
            end
        end
    end

    if love.keyboard.isDown('left', 'a') then
        if Player.x > 0 then
            Player.x = Player.x - (Player.speed * dt)
        end
    elseif love.keyboard.isDown('right', 'd') then
        if Player.x < (love.graphics.getWidth() - Player.img:getWidth()) then
            Player.x = Player.x + (Player.speed * dt)
        end
    end


    for i, mob in ipairs(Mobs) do
        for j, attackBox in ipairs(AttackBoxes) do
            if CheckCollision(mob.x, mob.y, mob.img:getWidth(), mob.img:getHeight(), attackBox.x, attackBox.y,
                attackBox.img:getWidth(), attackBox.img:getHeight()) then
                table.remove(AttackBoxes, j)
                table.remove(Enemies, i)
                Score = Score + 1
            end
        end

        if CheckCollision(mob.x, mob.y, mob.img:getWidth(), mob.img:getHeight(), Player.x, Player.y,
            Player.img:getWidth(), Player.img:getHeight())
            and IsAlive then
            table.remove(Mobs, i)
            IsAlive = false
        end
    end
end

function love.draw(dt)
    love.graphics.print("Keys: WASD + HJKL", 150, love.graphics.getHeight() / 2)

    for i, bullet in ipairs(AttackBoxes) do
        love.graphics.draw(bullet.img, bullet.x, bullet.y)
    end
    for i, mob in ipairs(Mobs) do
        love.graphics.draw(mob.img, mob.x, mob.y)
    end

    if IsAlive then
        love.graphics.draw(Player.img, Player.x, Player.y)
    else
        love.graphics.print("Oops", love.graphics:getWidth() / 2 - 50, love.graphics:getHeight() / 2 - 10)
    end

    for i, key in ipairs(KeyList) do
        love.graphics.print(KeyList, love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() / 2)
    end



end
