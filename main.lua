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
    -- force things to be re-required every time
    for packageName, _ in pairs(package.loaded) do
      if string.find(packageName, 'lib/') then
        package.loaded[packageName] = nil
      end
    end

    love.load()
  elseif key == 'escape' or key == 'q' then
    love.event.quit()
  elseif key == 'space' then
    game.togglePause()
  end
end
