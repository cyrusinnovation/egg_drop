module(..., package.seeall)

require "main_game"

function setup()
   main_game = MainGame()
end

function teardown()
   --main_game:cleanup()
   main_game = nil
end

function test_main_game_has_background()
   assert_table(main_game.background)
end


