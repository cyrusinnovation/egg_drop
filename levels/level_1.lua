require 'class'
require 'levels.level'

Level1 = class(Level)

function Level1:createLevel()
   self.mainGame.egg = Egg(display.contentWidth / 2)


   self.mainGame.nest = Nest(display.contentWidth / 2, display.contentHeight - 50)
   self.mainGame.nest:setX(self.mainGame.nest:getX() - self.mainGame.nest.sprite.width / 2)
end

function Level1:cleanup()
   self.mainGame.egg:cleanup()
   self.mainGame.nest:cleanup()
end