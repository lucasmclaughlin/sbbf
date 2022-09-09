Combo = {}
Combo.keys = { 'w', 'a', 's', 'd', 'h', 'j', 'k', 'l' }
Combo.keyTimerMax = .7
Combo.KeyTimer = Combo.keyTimerMax
Combo.keyList = {}


function Combo.comboKeys(key)
    for i, input in ipairs(Combo.keys) do
        if key == input then
            table.insert(Combo.keyList, #Combo.keyList + 1, input)
        end
        if Combo.keyList[i] == Combo.keyList[i - 1] then
            table.remove(Combo.keyList, i)
        end
    end
end

function Combo.checkCombo(key, keyInCombo)
    keyEntry = {}
    for i, keyInCombo in ipairs(Combo.keyList) do
        if key == keyInCombo then
            table.insert(keyEntry, #keyEntry + 1, keyInCombo)
            if #keyEntry >= #keyInCombo then
                love.graphics.print(Combo, Player.x, Player.y - 50)
            end
        end
    end
end

function Combo.update(dt)
    Combo.KeyTimer = Combo.KeyTimer - dt
    if Combo.KeyTimer < 0 then
        table.remove(Combo.keyList, 1)
        Combo.KeyTimer = Combo.keyTimerMax
    end
end

function Combo.print(dt)
    for i, key in ipairs(Combo.keyList) do
        love.graphics.print(Combo.keyList, love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() / 2)
    end
end
