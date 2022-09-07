MobImg = nil
Mobs = {}

function updateMobs(dt)
    -- move mobs and delete off screen mobs
    for i, mob in ipairs(Mobs) do
        mob.y = mob.y + (200 * dt)
        if mob.y > 850 then
            table.remove(Mobs, i)
        end
    end

    -- remove mobs hit by attacks
    for i, mob in ipairs(Mobs) do
        for j, attackBox in ipairs(AttackBoxes) do
            if CheckCollision(mob.x, mob.y, mob.img:getWidth(), mob.img:getHeight(), attackBox.x, attackBox.y,
                attackBox.img:getWidth(), attackBox.img:getHeight()) then
                table.remove(AttackBoxes, j)
                table.remove(Mobs, i)
                Score = Score + 1
            end
        end
        
        -- check for mobs hitting player
        if CheckCollision(mob.x, mob.y, mob.img:getWidth(), mob.img:getHeight(), Player.x, Player.y,
            Player.img:getWidth(), Player.img:getHeight())
            and Player.isAlive then
            table.remove(Mobs, i)
            Player.isAlive = false
        end
    end
end
function drawMobs(dt)
    for i, mob in ipairs(Mobs) do
        love.graphics.draw(mob.img, mob.x, mob.y)
    end
end
