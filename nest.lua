require 'class'
require 'game_sprite'

Nest = class(GameSprite)

function Nest:init(x, y)
   self.sprite = display.newImage( "nest.png", x, y )
   physics.addBody( self.sprite, 'static', { density=5.6, friction=10.6, bounce=0.0  } )
end