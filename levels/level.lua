require 'class'

Level = class()

function Level:init(mainGame)
   self.mainGame = mainGame
   self:createLevel()
end

function Level:createLevel()
end
