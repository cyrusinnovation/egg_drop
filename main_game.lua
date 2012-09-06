require 'class'
require 'egg'
require 'background'
require 'nest'

local physics = require("physics")

MainGame = class()

function MainGame:init()
   self.background = Background()
   self.egg = Egg()
   self.nest = Nest()
   self.state = 'falling'

   Runtime:addEventListener( "touch", function(event) self:onScreenTouch(event) end )
   Runtime:addEventListener( "collision", function(event) self:onCollision(event) end )
end


function MainGame:onCollision( event )
   if (event.phase == "began") then
      physics.pause()
      self:text('EGG-CELLENT!')
   end
end

function MainGame:text(text)
   self.instructionLabel = display.newText( text, display.contentWidth / 2 - 80, display.contentHeight / 2 - 50, "ComicSansMS", 27 )
   self.instructionLabel:setTextColor( 190, 255, 131, 150 )
end


function MainGame:mainGameLoop()
   if self:isDead() then
      self:text('TRY AGAIN!')
      self.state = 'dead'
   end

end

function MainGame:isDead()
   return self.state == 'falling' and self.egg.sprite.y > display.contentHeight + self.egg.sprite.height * 1.05
end

function MainGame:onScreenTouch( event )
  if event.phase == "began" then
     self:touchBegan()
  elseif event.phase == "moved" then
  elseif event.phase == "ended" or event.phase == "cancelled" then
  end

  return true
end


function MainGame:touchBegan()
   if self.state == 'dead' then
      self.egg:cleanup()
      self.egg = Egg()
      self.state = 'falling'
      self.instructionLabel:removeSelf()
      self.instructionLabel = nil
   end
end