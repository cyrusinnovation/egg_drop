require 'class'

Background = class()

function Background:init()
   self.sprite = display.newImage( "sky.png", 0, 0 )
   self.sprite.x = display.contentWidth / 2
   self.sprite.y = display.contentHeight / 2
end