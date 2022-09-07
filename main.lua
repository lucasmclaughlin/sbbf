debug = true
require("src.dependencies")

function love.load(arg)
    loadImages()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    comboKeys(key)
end

function love.update(dt)
    updateCombo(dt)
    Level.update(dt)
    updateMobs(dt)
    updatePlayer(dt)
end

function love.draw(dt)
    drawMobs(dt)
    drawPlayer(dt)

    -- where do bullets go. Are they player.bullet?
    for i, bullet in ipairs(AttackBoxes) do
        love.graphics.draw(bullet.img, bullet.x, bullet.y)
    end

    if debug then
        love.graphics.print("Keys: WASD + HJKL", 150, love.graphics.getHeight() / 2)
        printCombo(dt)
    end
end
