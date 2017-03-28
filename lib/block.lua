local colours = require 'lib/colours'

local createBlock = function()
  local self = {colourIndex = 1}

  local onLeftClick = function()
    self.colourIndex = self.colourIndex < #colours and self.colourIndex + 1 or 1
  end

  local onRightClick = function()
    self.colourIndex = self.colourIndex > 1 and self.colourIndex - 1 or #colours
  end

  local getColour = function()
    return colours[self.colourIndex]
  end

  return {
    onLeftClick = onLeftClick,
    onRightClick = onRightClick,
    getColour = getColour,
  }
end

return createBlock
