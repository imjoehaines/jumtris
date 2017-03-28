local config = require 'lib/config'
local colours = require 'lib/colours'

local isPaused = false

local grid = {}

local playMarker = {
  x = config.containerOffsetX
}

local activeGridX = playMarker.x

local isInsideContainer = function(x, y)
 return x >= config.containerOffsetX and
    x <= config.containerOffsetX + config.containerSize and
    y >= config.containerOffsetY and
    y <= config.containerOffsetY + config.containerSize
end

local game = {}

function game.load()
  -- initialise the grid
  for y = 0, config.squaresInRow - 1 do
    grid[y] = {}

    for x = 0, config.squaresInRow - 1 do
      grid[y][x] = 1
    end
  end

  playMarker.x = config.containerOffsetX
end

function game.draw()
  love.graphics.setBackgroundColor(236, 219, 188)
  love.graphics.setColor(255, 255, 255, 150)

  love.graphics.rectangle(
    'fill',
    config.containerOffsetX - config.containerPadding / 2,
    config.containerOffsetY - config.containerPadding / 2,
    config.containerSize + config.containerPadding,
    config.containerSize + config.containerPadding
  )

  for y = 0, #grid do
    for x = 0, #grid do
      local startX = config.containerOffsetX + config.squarePadding / 2
      local startY = config.containerOffsetY + config.squarePadding / 2

      local offsetX = startX + x * config.squareSize
      local offsetY = startY + y * config.squareSize

      local colour = colours[grid[y][x]]

      -- highlight the active column
      colour[4] = x == activeGridX and 150 or 255

      love.graphics.setColor(colour)
      love.graphics.rectangle(
        'fill',
        offsetX,
        offsetY,
        config.squareSize - config.squarePadding,
        config.squareSize - config.squarePadding
      )
    end
  end
end

function game.update(dt)
  if isPaused then return end

  playMarker.x = playMarker.x + (dt * config.playMarkerSpeed)

  if playMarker.x > config.containerOffsetX + config.containerSize then
    playMarker.x = config.containerOffsetX
  end

  activeGridX = math.floor((playMarker.x - config.containerOffsetX) / config.squareSize)
end

function game.mousepressed(x, y, button)
  if not isInsideContainer(x, y) then return end

  -- work out the x & y coordinates in the grid of the clicked position
  local gridX = math.floor((x - config.containerOffsetX) / config.squareSize)
  local gridY = math.floor((y - config.containerOffsetY) / config.squareSize)

  if button == 1 then
    grid[gridY][gridX] = grid[gridY][gridX] < #colours and grid[gridY][gridX] + 1 or 1
  else
    grid[gridY][gridX] = grid[gridY][gridX] > 1 and grid[gridY][gridX] - 1 or #colours
  end
end

function game.togglePause()
  isPaused = not isPaused
end

return game
