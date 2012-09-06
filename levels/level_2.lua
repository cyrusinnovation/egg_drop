require 'class'
require 'levels.level'

Level2 = class(Level)

function Level2:createLevel()
   self.mainGame.egg = Egg(display.contentWidth - 30)

   self.mainGame.nest = Nest(display.contentWidth / 4, display.contentHeight - 50)
   self.mainGame.nest:setX(self.mainGame.nest:getX() - self.mainGame.nest.sprite.width / 2)
end
