local config = require 'lib/config'
local createBlock = require 'lib/block'

local isPaused = false
local startX = config.containerOffsetX + config.squarePadding / 2
local startY = config.containerOffsetY + config.squarePadding / 2
local playMarker = config.containerOffsetX
local activeGridX = playMarker

local isInsideContainer = function(x, y)
 return x >= config.containerOffsetX and
    x <= config.containerOffsetX + config.containerSize and
    y >= config.containerOffsetY and
    y <= config.containerOffsetY + config.containerSize
end

local grid = {}
local game = {}

function game.load()
  -- initialise the grid
  for y = 0, config.squaresInRow - 1 do
    grid[y] = {}

    for x = 0, config.squaresInRow - 1 do
      grid[y][x] = createBlock(x, y)
    end
  end

  playMarker = config.containerOffsetX
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
      grid[y][x].draw(startX, startY)
    end
  end

  love.graphics.setColor(255, 255, 255, 50)
  love.graphics.rectangle(
    'fill',
    startX + activeGridX * config.squareSize,
    startY,
    config.squareSize - config.squarePadding,
    config.containerSize - config.squarePadding
  )
end

function game.update(dt)
  if isPaused then return end

  playMarker = playMarker + (dt * config.playMarkerSpeed)

  if playMarker > config.containerOffsetX + config.containerSize then
    playMarker = config.containerOffsetX
  end

  activeGridX = math.floor((playMarker - config.containerOffsetX) / config.squareSize)
end

function game.mousepressed(x, y, button)
  if not isInsideContainer(x, y) then return end

  -- work out the x & y coordinates in the grid of the clicked position
  local gridX = math.floor((x - config.containerOffsetX) / config.squareSize)
  local gridY = math.floor((y - config.containerOffsetY) / config.squareSize)

  if button == 1 then
    grid[gridY][gridX].onLeftClick()
  elseif button == 2 then
    grid[gridY][gridX].onRightClick()
  end
end

function game.togglePause()
  isPaused = not isPaused
end

return game
