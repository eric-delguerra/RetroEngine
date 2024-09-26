local RE = require('RetroEngine/RetroEngine'):new('GB')

function love.load()
    RE:load()
end

function love.update(dt)
    RE:update(dt)
    if RE:hasBooted() then
        -- Your game logic here
    end
end

function love.draw()
    RE:draw()
end

function love.keypressed(key)

end