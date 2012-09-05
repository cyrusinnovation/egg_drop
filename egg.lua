require 'class'

Egg = class()

function Egg:init()
   local sprite = display.newImage( "egg.png" )
   sprite.x = 40 + math.random( display.contentWidth / 2 ); sprite.y = -40
   physics.addBody( sprite, { density=0.6, friction=0.6, bounce=0.6, radius=19 } )
   sprite.angularVelocity = math.random(600) - 300
   sprite.isSleepingAllowed = false

   self.sprite = sprite
end
