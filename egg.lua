require 'class'

Egg = class()

function Egg:init()
   local sprite = display.newImage( "egg.png" )
   sprite.x = display.contentWidth / 2
   sprite.y = -40

   local eggShape = { 0,-30, 22,-10, 16,26, 2, 30,  -2, 30,  -16,26, -22,-10 }

   physics.addBody( sprite, { density=0.6, friction=0.6, bounce=0.0, radius=19, shape=eggShape } )
   sprite.angularVelocity = math.random(100) - 50
   sprite.isSleepingAllowed = false

   self.sprite = sprite
end

function Egg:cleanup()
   self.sprite:removeSelf()
end