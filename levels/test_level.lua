require 'class'
require 'levels.level'

TestLevel = class(Level)

function TestLevel:createLevel()
   self.mainGame.egg = Egg(0)
   self.mainGame.nest = Nest(display.contentWidth / 2, display.contentHeight - 50)
   self.mainGame.nest:setX(self.mainGame.nest:getX() - self.mainGame.nest.sprite.width / 2)
end