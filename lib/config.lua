local config = {}

config.playMarkerSpeed = 200
config.containerPadding = 2
config.containerWindowOffset = 100
config.squaresInRow = 10

local windowWidth, windowHeight = love.graphics.getDimensions()

config.windowWidth = windowWidth
config.windowHeight = windowHeight
config.containerSize = math.min(windowWidth, windowHeight) - config.containerWindowOffset
config.containerOffsetX = config.windowWidth / 2 - config.containerSize / 2
config.containerOffsetY = config.windowHeight / 2 - config.containerSize / 2
config.squarePadding = config.containerPadding
config.squareSize = config.containerSize / config.squaresInRow

return config
