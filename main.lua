require 'main_game'

local physics = require("physics")
physics.start()

display.setStatusBar( display.HiddenStatusBar )

if os.getenv("LUA_TEST") then
   require "lunatest.lunatest"

   lunatest.suite("tests.main_game_test")
   lunatest.suite("tests.egg_test")

   lunatest.run()
   os.exit()
end

display.setStatusBar( display.HiddenStatusBar )

local main_game = MainGame()

function loop()
   main_game:mainGameLoop()
end

Runtime:addEventListener( "enterFrame", loop )


-- local fps = require("fps")
-- local performance = fps.PerformanceOutput.new();
-- performance.group.x, performance.group.y = display.contentWidth/2,  0;
-- performance.alpha = 0.6; -- So it doesn't get in the way of the rest of the scene