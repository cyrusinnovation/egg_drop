require 'class'
require 'levels.level'
require 'trampoline'

Level2 = class(Level)

function Level2:createLevel()
   self.mainGame.egg = Egg(display.contentWidth - 80)

   self.mainGame.nest = Nest(display.contentWidth / 4, display.contentHeight - 50)
   self.mainGame.nest:setX(self.mainGame.nest:getX() - self.mainGame.nest.sprite.width / 2)
   self.trampoline = Trampoline()
   self.trampoline:create(200, 400, 300, 390)
end

function Level2:cleanup()
   self.mainGame.egg:cleanup()
   self.mainGame.nest:cleanup()
   self.trampoline:cleanup()
end