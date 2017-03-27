local WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()
local CONTAINER_PADDING = 2
local CONTAINER_WINDOW_OFFSET = 100
local CONTAINER_SIZE = math.min(WINDOW_WIDTH, WINDOW_HEIGHT) - CONTAINER_WINDOW_OFFSET
local CONTAINER_OFFSET_X = WINDOW_WIDTH / 2 - CONTAINER_SIZE / 2
local CONTAINER_OFFSET_Y = WINDOW_HEIGHT / 2 - CONTAINER_SIZE / 2

local SQUARES_IN_ROW = 10
local SQUARE_PADDING = CONTAINER_PADDING
local SQUARE_SIZE = CONTAINER_SIZE / SQUARES_IN_ROW

local PLAY_MARKER_SPEED = 200

local grid = {}
local GRID_COLOURS = {}

local COLOUR_DEFAULT = 0
local COLOUR_BLUE = 1
local COLOUR_GREEN = 2
local COLOUR_PINK = 3
local COLOUR_PURPLE = 4
local COLOUR_RED = 5

GRID_COLOURS[COLOUR_DEFAULT] = {236, 219, 188}
GRID_COLOURS[COLOUR_BLUE] = {170, 201, 216}
GRID_COLOURS[COLOUR_GREEN] = {182, 216, 192}
GRID_COLOURS[COLOUR_PINK] = {236, 180, 236}
GRID_COLOURS[COLOUR_PURPLE] = {206, 190, 234}
GRID_COLOURS[COLOUR_RED] = {255, 158, 158}

local playMarker = {
  x = CONTAINER_OFFSET_X
}

local activeGridX = playMarker.x

local isInsideContainer = function(x, y)
 return x >= CONTAINER_OFFSET_X and
    x <= CONTAINER_OFFSET_X + CONTAINER_SIZE and
    y >= CONTAINER_OFFSET_Y and
    y <= CONTAINER_OFFSET_Y + CONTAINER_SIZE
end

local game = {}

function game.load()
  -- initialise the grid
  for y = 0, SQUARES_IN_ROW - 1 do
    grid[y] = {}

    for x = 0, SQUARES_IN_ROW - 1 do
      grid[y][x] = 0
    end
  end

  playMarker.x = CONTAINER_OFFSET_X
end

function game.draw()
  love.graphics.setBackgroundColor(236, 219, 188)
  love.graphics.setColor(255, 255, 255, 150)

  love.graphics.rectangle(
    'fill',
    CONTAINER_OFFSET_X - CONTAINER_PADDING / 2,
    CONTAINER_OFFSET_Y - CONTAINER_PADDING / 2,
    CONTAINER_SIZE + CONTAINER_PADDING,
    CONTAINER_SIZE + CONTAINER_PADDING
  )

  for y = 0, #grid do
    for x = 0, #grid do
      local startX = CONTAINER_OFFSET_X + SQUARE_PADDING / 2
      local startY = CONTAINER_OFFSET_Y + SQUARE_PADDING / 2

      local offsetX = startX + x * SQUARE_SIZE
      local offsetY = startY + y * SQUARE_SIZE

      local colour = GRID_COLOURS[grid[y][x]]

      -- highlight the active column
      colour[4] = x == activeGridX and 150 or 255

      love.graphics.setColor(colour)
      love.graphics.rectangle(
        'fill',
        offsetX,
        offsetY,
        SQUARE_SIZE - SQUARE_PADDING,
        SQUARE_SIZE - SQUARE_PADDING
      )
    end
  end
end

function game.update(dt)
  playMarker.x = playMarker.x + (dt * PLAY_MARKER_SPEED)

  if playMarker.x > CONTAINER_OFFSET_X + CONTAINER_SIZE then
    playMarker.x = CONTAINER_OFFSET_X
  end

  activeGridX = math.floor((playMarker.x - CONTAINER_OFFSET_X) / SQUARE_SIZE)
end

function game.mousepressed(x, y, button)
  if not isInsideContainer(x, y) then return end

  -- work out the x & y coordinates in the grid of the clicked position
  local gridX = math.floor((x - CONTAINER_OFFSET_X) / SQUARE_SIZE)
  local gridY = math.floor((y - CONTAINER_OFFSET_Y) / SQUARE_SIZE)

  if button == 1 then
    grid[gridY][gridX] = grid[gridY][gridX] < COLOUR_RED and grid[gridY][gridX] + 1 or COLOUR_DEFAULT
  else
    grid[gridY][gridX] = grid[gridY][gridX] > COLOUR_DEFAULT and grid[gridY][gridX] - 1 or COLOUR_RED
  end
end

return game
