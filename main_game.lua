require 'class'
require 'egg'
require 'background'
require 'nest'
require 'trampoline'
require 'levels.level_2'
require 'levels.level_3'

local physics = require("physics")

MainGame = class()

function MainGame:init(Level)
   self.background = Background()
   self.trampolines = {}
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
   self.level:cleanup()
   for i, trampoline in ipairs(self.trampolines) do
      trampoline:cleanup()
   end
   self.trampolines = {}
   self.lastY = nil
end

function MainGame:displayText(text)
   if self.label then
      print('You should have cleaned up your old string bad boy.')
      self:removeLabel()
   end

   self.label = display.newText( text, display.contentWidth / 2 - 80, display.contentHeight / 2 - 50, system.nativeFont, 27 )
   self.label:setTextColor( 190, 255, 131, 150 )
end

function MainGame:mainGameLoop()
   if self:isDead() then
      self:displayText('TRY AGAIN!')
      self.state = 'dead'
      physics.pause()
   end

   if self.lastY and self.state == 'falling' and (self.egg:getY() < self.lastY) then
      self.egg.sprite:applyForce(0, -3200.0, self.egg:getX(), self.egg:getY())
      self.state = 'boosted'
   end
   
   if self.state == 'boosted' and (self.egg:getY() > self.lastY) then
      self.state = 'falling'
   end

   self.lastY = self.egg:getY()
end

function MainGame:isDead()
   return self.state == 'falling' and self.egg:getY() > display.contentHeight + self.egg.sprite.height * 1.05
end

function MainGame:onScreenTouch( event )
  if event.phase == "began" then
     self:touchBegan(event)
  elseif event.phase == "moved" then
  elseif event.phase == "ended" or event.phase == "cancelled" then
     self:touchEnded(event)
  end

  return true
end

function MainGame:onCollision( event )
   if (event.phase == "began" and self:didEggHitNest(event.object1, event.object2)) then
      physics.pause()
      self.state = 'won'
      self:displayText('EGG-CELLENT!')
   end
end

function MainGame:touchBegan(event)
   if self.state == 'dead' then
      self:reloadLevel()
      self:removeLabel()
   elseif self.state == 'won' then
      self:removeLabel()
      level = math.random(0, 1)
      if level == 0 then
	 self:newLevel(Level2)
      else
	 self:newLevel(Level3)
      end
   elseif self:isPlayingState() then
      self.startTrampoline = {x = event.x, y = event.y}
   end
end

function MainGame:touchEnded(event)
   if self:isPlayingState() and self.startTrampoline then
      local trampoline = Trampoline(self.startTrampoline.x, self.startTrampoline.y, event.x, event.y)
      table.insert(self.trampolines, trampoline)
      local startFade = function() trampoline:fadeOut(self); end
      timer.performWithDelay(2000, startFade)
   end
end

function MainGame:isPlayingState()
   return self.state == 'falling' or self.state == 'boosted'
end

function MainGame:didEggHitNest(object1, object2)
   return ((object1 == self.nest.sprite and object2 == self.egg.sprite) or (object2 == self.nest.sprite and object1 == self.egg.sprite))
end

function MainGame:removeLabel()
   if self.label then
      self.label:removeSelf()
      self.label = nil
   end
end

function MainGame:removeTrampoline(trampolineToRemove)
   local trampolineToRemoveIndex = 0

   for i, trampoline in ipairs(self.trampolines) do
      if trampoline == trampolineToRemove then
	 trampolineToRemoveIndex = i
      end
   end
   trampolineToRemove:cleanup()
   table.remove(self.trampolines, trampolineToRemoveIndex)
end