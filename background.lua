require 'class'
require 'game_sprite'

Background = class(GameSprite)

function Background:init()
   self.sprite = display.newImage( "sky.png", 0, 0 )
   self.sprite.x = display.contentWidth / 2
   self.sprite.y = display.contentHeight / 2
end