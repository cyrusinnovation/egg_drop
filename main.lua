require 'egg'

local physics = require("physics")
physics.start()

display.setStatusBar( display.HiddenStatusBar )

if os.getenv("LUA_TEST") then
   require "lunatest.lunatest"

   --lunatest.suite("tests.main_game_test")
   lunatest.suite("tests.egg_test")

   lunatest.run()
   os.exit()
end

display.setStatusBar( display.HiddenStatusBar )

--local main_game = MainGame(Level1())

function loop()
   --main_game:mainGameLoop()
end

--Runtime:addEventListener( "enterFrame", loop )

-- The final "true" parameter overrides Corona's auto-scaling of large images
local background = display.newImage( "sky.png", 0, 0, true )
background.x = display.contentWidth / 2
background.y = display.contentHeight / 2


local instructionLabel = display.newText( "TRY AGAIN!", display.contentWidth / 2 - 50, display.contentHeight / 2 - 50, "ComicSansMS", 17 )
instructionLabel:setTextColor( 190, 255, 131, 150 )

local egg = Egg()


-- local fps = require("fps")
-- local performance = fps.PerformanceOutput.new();
-- performance.group.x, performance.group.y = display.contentWidth/2,  0;
-- performance.alpha = 0.6; -- So it doesn't get in the way of the rest of the scene