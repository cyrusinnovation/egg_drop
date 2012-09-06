require 'class'
require 'egg'
require 'background'
require 'nest'
require 'levels.level_2'

local physics = require("physics")

MainGame = class()

function MainGame:init(Level)
   self.background = Background()
   self:newLevel(Level)

   self.screenTouch = function(event) self:onScreenTouch(event) end
   self.collision = function(event) self:onCollision(event) end

   Runtime:addEventListener( "touch", self.screenTouch )
   Runtime:addEventListener( "collision", self.collision )
end

function MainGame:cleanup()
   self:unloadLevel()
   self.background:cleanup()

   Runtime:removeEventListener( "touch", self.screenTouch )
   Runtime:removeEventListener( "collision", self.collision )
end

function MainGame:reloadLevel()
   self:unloadLevel()
   self.level:createLevel()

   physics.start()
   self.state = 'falling'
end

function MainGame:newLevel(Level)
   if self.level then
      self:unloadLevel()
   end

   self.level = Level(self)

   physics.start()
   self.state = 'falling'
end

function MainGame:unloadLevel()
   self.egg:cleanup()
   self.nest:cleanup()
end

function MainGame:displayText(text)
   if self.label then
      print('You should have cleaned up your old string bad boy.')
      self:removeLabel()
   end

   self.label = display.newText( text, display.contentWidth / 2 - 80, display.contentHeight / 2 - 50, "ComicSansMS", 27 )
   self.label:setTextColor( 190, 255, 131, 150 )
end

function MainGame:mainGameLoop()
   if self:isDead() then
      self:displayText('TRY AGAIN!')
      self.state = 'dead'
      physics.pause()
   end
end

function MainGame:isDead()
   return self.state == 'falling' and self.egg:getY() > display.contentHeight + self.egg.sprite.height * 1.05
end

function MainGame:onScreenTouch( event )
  if event.phase == "began" then
     self:touchBegan()
  elseif event.phase == "moved" then
  elseif event.phase == "ended" or event.phase == "cancelled" then
  end

  return true
end

function MainGame:onCollision( event )
   if (event.phase == "began") then
      physics.pause()
      self.state = 'won'
      self:displayText('EGG-CELLENT!')
   end
end

function MainGame:touchBegan()
   if self.state == 'dead' then
      self:reloadLevel()
      self:removeLabel()
   end

   if self.state == 'won' then
      self:removeLabel()
      self:newLevel(Level2)
   end
end

function MainGame:createNewEgg()
   self.egg:cleanup()
   self.egg = Egg()
end

function MainGame:removeLabel()
   if self.label then
      self.label:removeSelf()
      self.label = nil
   end
end