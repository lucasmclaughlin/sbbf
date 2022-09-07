Keys = { 'w', 'a', 's', 'd', 'h', 'j', 'k', 'l' }
KeyTimerMax = .7
KeyTimer = KeyTimerMax
KeyList = {}


function comboKeys(key)
    for i, input in ipairs(Keys) do
        if key == input then
            table.insert(KeyList, #KeyList + 1, input)
        end
        if KeyList[i] == KeyList[i - 1] then
            table.remove(KeyList, i)
        end
    end
end

function updateCombo(dt)
    KeyTimer = KeyTimer - dt
    if KeyTimer < 0 then
        table.remove(KeyList, 1)
        KeyTimer = KeyTimerMax
    end
end

function printCombo(dt)
    for i, key in ipairs(KeyList) do
        love.graphics.print(KeyList, love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() / 2)
    end
end
