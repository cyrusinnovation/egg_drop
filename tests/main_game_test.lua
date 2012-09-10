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
   main_game.egg:setPos(main_game.nest:getPos())

   local event = {phase = 'began', object1 = main_game.egg.sprite, object2 = main_game.nest.sprite}
   main_game:onCollision(event)
   assert_equal('EGG-CELLENT!', main_game.label.text)
   assert_equal('won', main_game.state)
end

function test_can_move_to_next_level()
   main_game.state = 'won'
   main_game:touchBegan()

   assert_equal('falling', main_game.state)
end

function test_can_place_trampolines()
   main_game:touchBegan({x = 100, y = 100})
   main_game:touchEnded({x = 200, y = 100})
   assert_equal(#main_game.trampolines, 1)
end

function test_unload_level()
   main_game:displayText('remove me')
   local trampoline = Trampoline(0, 0, 10, 10)
   table.insert(main_game.trampolines, trampoline)
   main_game.startTrampoline = {x = 0, y = 0}

   main_game:unloadLevel()

   assert_equal(0, #main_game.trampolines)
   assert_nil(main_game.label)
   assert_nil(main_game.startTrampoline)
end