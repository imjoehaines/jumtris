local WINDOW_WIDTH, WINDOW_HEIGHT = love.graphics.getDimensions()
local CONTAINER_PADDING = 20
local CONTAINER_SIZE = math.min(WINDOW_WIDTH, WINDOW_HEIGHT) - 200
local CONTAINER_OFFSET_X = WINDOW_WIDTH / 2 - CONTAINER_SIZE / 2
local CONTAINER_OFFSET_Y = WINDOW_HEIGHT / 2 - CONTAINER_SIZE / 2

local SQUARES_IN_CONTAINER = 10
local SQUARE_PADDING = CONTAINER_PADDING / SQUARES_IN_CONTAINER
local SQUARE_SIZE = CONTAINER_SIZE / SQUARES_IN_CONTAINER

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

  for y = 0, SQUARES_IN_CONTAINER - 1 do
    for x = 0, SQUARES_IN_CONTAINER - 1 do
      local startX = CONTAINER_OFFSET_X + SQUARE_PADDING / 2
      local startY = CONTAINER_OFFSET_Y + SQUARE_PADDING / 2

      local offsetX = startX + x * SQUARE_SIZE
      local offsetY = startY + y * SQUARE_SIZE

      love.graphics.setColor(236, 219, 188, 200)
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
