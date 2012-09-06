module(..., package.seeall)

require "main_game"

function setup()
   main_game = MainGame()
end

function teardown()
   main_game:cleanup()
   main_game = nil
end

function test_main_game_has_background()
   assert_table(main_game.background)
end

function test_dead()
   main_game.egg.sprite.x = 0
   main_game.egg.sprite.y = 1000
   main_game:mainGameLoop()
   assert_equal('dead', main_game.state)
   assert_equal('TRY AGAIN!', main_game.label.text)
end

function test_can_restart_lost_game()
   main_game.egg.sprite.x = 0
   main_game.egg.sprite.y = 1000
   main_game:mainGameLoop()

   main_game:touchBegan()
   assert_equal('falling', main_game.state)
   assert_nil(main_game.label)
   assert_lt(0, main_game.egg.sprite.y)
end
