require 'class'
require 'levels.level'

Level3 = class(Level)

function Level3:createLevel()
   self.mainGame.egg = Egg(display.contentWidth - 80)

   self.mainGame.nest = Nest(display.contentWidth / 4, 100)
   self.mainGame.nest:setX(self.mainGame.nest:getX() - self.mainGame.nest.sprite.width / 2)
end

function Level3:cleanup()
   self.mainGame.egg:cleanup()
   self.mainGame.nest:cleanup()
end