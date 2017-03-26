local WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()
local CONTAINER_PADDING = 20
local CONTAINER_WINDOW_OFFSET = 200
local CONTAINER_SIZE = math.min(WINDOW_WIDTH, WINDOW_HEIGHT) - CONTAINER_WINDOW_OFFSET
local CONTAINER_OFFSET_X = WINDOW_WIDTH / 2 - CONTAINER_SIZE / 2
local CONTAINER_OFFSET_Y = WINDOW_HEIGHT / 2 - CONTAINER_SIZE / 2

local SQUARES_IN_ROW = 10
local SQUARE_PADDING = CONTAINER_PADDING / SQUARES_IN_ROW
local SQUARE_SIZE = CONTAINER_SIZE / SQUARES_IN_ROW

-- initialise the grid
local grid = {}
for y = 0, SQUARES_IN_ROW - 1 do
  grid[y] = {}

  for x = 0, SQUARES_IN_ROW - 1 do
    grid[y][x] = 0
  end
end

local COLOUR_DEFAULT = 0
local COLOUR_BLUE = 1 -- vertical blocks
local COLOUR_GREEN = 2 -- horizontal blocks
local COLOUR_PINK = 3 -- square blocks
local COLOUR_PURPLE = 4 -- small "L" blocks
local COLOUR_RED = 5 -- large "L" blocks

local GRID_COLOURS = {}
GRID_COLOURS[COLOUR_DEFAULT] = {236, 219, 188, 200}
GRID_COLOURS[COLOUR_BLUE] = {170, 201, 199, 200}
GRID_COLOURS[COLOUR_GREEN] = {182, 216, 192, 200}
GRID_COLOURS[COLOUR_PINK] = {230, 198, 231, 200}
GRID_COLOURS[COLOUR_PURPLE] = {210, 197, 232, 200}
GRID_COLOURS[COLOUR_RED] = {255, 158, 158, 200}

function love.draw()
  love.graphics.setBackgroundColor(236, 219, 188)
  love.graphics.setColor(255, 255, 255, 150)

  love.graphics.rectangle(
    'fill',
    CONTAINER_OFFSET_X - CONTAINER_PADDING / 2,
    CONTAINER_OFFSET_Y - CONTAINER_PADDING / 2,
    CONTAINER_SIZE + CONTAINER_PADDING,
    CONTAINER_SIZE + CONTAINER_PADDING,
    10,
    10
  )

  for y = 0, #grid do
    for x = 0, #grid do
      local startX = CONTAINER_OFFSET_X + SQUARE_PADDING / 2
      local startY = CONTAINER_OFFSET_Y + SQUARE_PADDING / 2

      local offsetX = startX + x * SQUARE_SIZE
      local offsetY = startY + y * SQUARE_SIZE

      local colour = GRID_COLOURS[grid[y][x]]

      love.graphics.setColor(colour)
      love.graphics.rectangle(
        'fill',
        offsetX,
        offsetY,
        SQUARE_SIZE - SQUARE_PADDING,
        SQUARE_SIZE - SQUARE_PADDING,
        10,
        10
      )
    end
  end
end

local isInsideContainer = function(x, y)
 return x >= CONTAINER_OFFSET_X and
    x <= CONTAINER_OFFSET_X + CONTAINER_SIZE and
    y >= CONTAINER_OFFSET_Y and
    y <= CONTAINER_OFFSET_Y + CONTAINER_SIZE
end

function love.mousepressed(x, y, button)
  if button ~= 1 then return end

  if isInsideContainer(x, y) then
    -- work out the x & y coordinates in the grid of the clicked position
    local gridX = math.floor((x - CONTAINER_OFFSET_X) / SQUARE_SIZE)
    local gridY = math.floor((y - CONTAINER_OFFSET_Y) / SQUARE_SIZE)

    grid[gridY][gridX] = grid[gridY][gridX] < COLOUR_RED and grid[gridY][gridX] + 1 or COLOUR_DEFAULT
  end
end
