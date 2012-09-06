module(..., package.seeall)

require "egg"

function setup()
   egg = Egg(30)
end

function teardown()
   egg:cleanup()
   egg = nil
end

function test_egg_has_sprite()
   assert_table(egg.sprite)
end

function test_egg_starting_pos()
   assert_equal(30, egg.sprite.x)
   assert_equal(-40, egg.sprite.y)
end

