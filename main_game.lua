require 'class'
require 'egg'

MainGame = class()

function MainGame:init()
   -- The final "true" parameter overrides Corona's auto-scaling of large images
   self.background = display.newImage( "sky.png", 0, 0, true )
   self.background.x = display.contentWidth / 2
   self.background.y = display.contentHeight / 2

   self.egg = Egg()

   self.state = 'falling'

   Runtime:addEventListener( "touch", function(event) self:onScreenTouch(event) end )
end


function MainGame:mainGameLoop()

   if self.state == 'falling' and self.egg.sprite.y > display.contentHeight + self.egg.sprite.height * 1.05 then
      self.instructionLabel = display.newText( "TRY AGAIN!", display.contentWidth / 2 - 50, display.contentHeight / 2 - 50, "ComicSansMS", 17 )
      self.instructionLabel:setTextColor( 190, 255, 131, 150 )
      self.state = 'dead'
   end

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