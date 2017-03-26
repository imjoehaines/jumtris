local WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()

function love.draw()
  local size = math.min(WINDOW_WIDTH, WINDOW_HEIGHT) - 200
  local offsetX = math.floor(WINDOW_WIDTH / 2) - size / 2
  local offsetY = math.floor(WINDOW_HEIGHT / 2) - size / 2

  love.graphics.setBackgroundColor(236, 219, 188)
  love.graphics.setColor(255, 255, 255, 150)

  love.graphics.rectangle('fill', offsetX, offsetY, size, size, 10, 10)
end
