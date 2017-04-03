local colours = require 'lib/colours'
local config = require 'lib/config'

local createBlock = function(x, y)
  local self = {
    colourIndex = 1,
    x = x,
    y = y,
  }

  local onLeftClick = function()
    self.colourIndex = self.colourIndex < #colours and self.colourIndex + 1 or 1
  end

  local onRightClick = function()
    self.colourIndex = self.colourIndex > 1 and self.colourIndex - 1 or #colours
  end

  local draw = function(startX, startY)
    local offsetX = startX + self.x * config.squareSize
    local offsetY = startY + self.y * config.squareSize

    local colour = colours[self.colourIndex]

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
