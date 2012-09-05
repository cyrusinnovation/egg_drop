local physics = require("physics")
physics.start()

display.setStatusBar( display.HiddenStatusBar )

if os.getenv("LUA_TEST") then
   require "lunatest.lunatest"

   lunatest.suite("tests.main_game_test")
   lunatest.suite("tests.egg_test")
   lunatest.suite("tests.zombie_test")
   lunatest.suite("tests.wall_test")

   lunatest.run()
   os.exit()
end

display.setStatusBar( display.HiddenStatusBar )

--local main_game = MainGame(Level1())

function loop()
   --main_game:mainGameLoop()
end

--Runtime:addEventListener( "enterFrame", loop )


-- function to drop random coconuts and rocks
local egg = display.newImage( "egg.png" )
egg.x = 40 + math.random( display.contentWidth / 2 ); egg.y = -40
physics.addBody( egg, { density=0.6, friction=0.6, bounce=0.6, radius=19 } )
egg.angularVelocity = math.random(600) - 300
egg.isSleepingAllowed = false


-- local fps = require("fps")
-- local performance = fps.PerformanceOutput.new();
-- performance.group.x, performance.group.y = display.contentWidth/2,  0;
-- performance.alpha = 0.6; -- So it doesn't get in the way of the rest of the scene