module(..., package.seeall)

require "main_game"
require "levels.test_level"

function setup()
   main_game = MainGame(TestLevel)
end

function teardown()
   main_game:cleanup()
   main_game = nil
end

function test_main_game_has_background()
   assert_table(main_game.background)
end

function test_dead()
   main_game.egg:setY(1000)
   main_game:mainGameLoop()

   assert_equal('dead', main_game.state)
   assert_equal('TRY AGAIN!', main_game.label.text)
end

function test_can_restart_lost_game()
   main_game.egg:setY(1000)
   main_game:mainGameLoop()

   main_game:touchBegan()

   assert_equal('falling', main_game.state)
   assert_nil(main_game.label)
   assert_lt(0, main_game.egg:getY())
end

function test_can_finish_level()
   -- main_game.egg:setPos(main_game.nest:getPos())
   -- main_game.egg:setY(main_game.egg:getY() - 20)
   for x=1,100 do main_game:mainGameLoop(); end

   assert_equal('EGG-CELLENT!', main_game.label.text)
end

function test_can_move_to_next_level()
   main_game.state = 'won'
   main_game:touchBegan()

   assert_equal('EGG-CELLENT!', main_game.label.text)
end
