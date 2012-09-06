require 'class'
require 'game_sprite'

Nest = class(GameSprite)

function Nest:init()
   self.sprite = display.newImage( "nest.png", display.contentWidth / 2, display.contentHeight - 50 )
   self.sprite.x = self.sprite.x - self.sprite.width / 2
   physics.addBody( self.sprite, 'static', { density=5.6, friction=10.6, bounce=0.0  } )
end