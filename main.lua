debug = true
require("src.dependencies")

function love.load(arg)
    loadImages()
end

function love.keypressed(key, scancode, isrepeat)
    if key == "escape" then
        love.event.quit()
    end

    Combo.comboKeys(key)
    Combo.checkCombo(key, {a, d, h})
end

function love.update(dt)
    Combo.update(dt)
    Level.update(dt)
    Mobs.update(dt)
    Player.update(dt)
end

function love.draw(dt)
    Mobs.draw(dt)
    Player.draw(dt)

    -- where do bullets go. Are they player.bullet?
    for i, bullet in ipairs(Player.attackBoxes) do
        love.graphics.draw(bullet.img, bullet.x, bullet.y)
    end

    if debug then
        love.graphics.print("Keys: WASD + HJKL", 150, love.graphics.getHeight() / 2)
        Combo.print(dt)
    end
end
