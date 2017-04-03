local colours = require 'lib/colours'
local config = require 'lib/config'

local createBlock = function(x, y)
  local block = {
    colourIndex = 1,
    x = x,
    y = y,
  }

  local onLeftClick = function()
    block.colourIndex = block.colourIndex < #colours and block.colourIndex + 1 or 1
  end

  local onRightClick = function()
    block.colourIndex = block.colourIndex > 1 and block.colourIndex - 1 or #colours
  end

  local draw = function(startX, startY)
    local offsetX = startX + block.x * config.squareSize
    local offsetY = startY + block.y * config.squareSize

    local colour = colours[block.colourIndex]

    love.graphics.setColor(colour)
    love.graphics.rectangle(
      'fill',
      offsetX,
      offsetY,
      config.squareSize - config.squarePadding,
      config.squareSize - config.squarePadding
    )
  end

  return {
    onLeftClick = onLeftClick,
    onRightClick = onRightClick,
    draw = draw,
  }
end

return createBlock
