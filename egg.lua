require 'class'
require 'game_sprite'

Egg = class(GameSprite)

function Egg:init()
   self.sprite = display.newImage( "egg.png" )
   self.sprite.x = display.contentWidth / 2
   self.sprite.y = -40

   local eggShape = { 0,-30, 22,-10, 16,26, 2, 30,  -2, 30, -16,26, -22,-10 }

   physics.addBody( self.sprite, { density=0.6, friction=0.6, bounce=0.0, radius=19, shape=eggShape } )
   self.sprite.angularVelocity = math.random(100) - 50
end
