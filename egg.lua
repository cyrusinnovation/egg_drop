require 'class'

Egg = class()

function Egg:init()
   local sprite = display.newImage( "egg.png" )
   sprite.x = display.contentWidth / 2
   sprite.y = -40
   physics.addBody( sprite, { density=0.6, friction=0.6, bounce=0.0, radius=19 } )
   sprite.angularVelocity = math.random(100) - 50
   sprite.isSleepingAllowed = false

   self.sprite = sprite
end

function Egg:cleanup()
   self.sprite:removeSelf()
end