Player = { x = 200, y = 710, speed = 400, img = nil, isAlive = true, score = 0 }
AttackBoxes = {}

function updatePlayer(dt)
    -- Player movement
    if love.keyboard.isDown('left', 'a') then
        if Player.x > 0 then
            Player.x = Player.x - (Player.speed * dt)
        end
    elseif love.keyboard.isDown('right', 'd') then
        if Player.x < (love.graphics.getWidth() - Player.img:getWidth()) then
            Player.x = Player.x + (Player.speed * dt)
        end
    end
end
function drawPlayer(dt)
    if Player.isAlive then
        love.graphics.draw(Player.img, Player.x, Player.y)
    else
        love.graphics.print("Oops", love.graphics:getWidth() / 2 - 50, love.graphics:getHeight() / 2 - 10)
    end
end
