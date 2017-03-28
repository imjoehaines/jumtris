local game

function love.load()
  game = require 'lib/game'
  game.load()
end

function love.draw()
  game.draw()
end

function love.update(dt)
  game.update(dt)
end

function love.mousepressed(x, y, button)
  game.mousepressed(x, y, button)
end

function love.keypressed(key)
  if key == 'r' then
    -- force game to be re-required every time
    package.loaded.game = nil
    love.load()
  elseif key == 'escape' or key == 'q' then
    love.event.quit()
  elseif key == 'space' then
    game.togglePause()
  end
end
