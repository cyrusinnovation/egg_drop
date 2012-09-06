require 'class'

GameSprite = class()

function GameSprite:getX()
   return self.sprite.x
end

function GameSprite:getY()
   return self.sprite.y
end

function GameSprite:setX(x)
   self.sprite.x = x
end

function GameSprite:setY(y)
   self.sprite.y = y
end

function GameSprite:getPos()
   return self.sprite.x, self.sprite.y
end

function GameSprite:setPos(x, y)
   self.sprite.x = x
   self.sprite.y = y
end

function GameSprite:cleanup()
   self.sprite:removeSelf()
end
