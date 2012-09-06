module(..., package.seeall)

require "egg"

function setup()
   egg = Egg()
end

function teardown()
   egg:cleanup()
   egg = nil
end

function test_egg_has_sprite()
   assert_table(egg.sprite)
end

function test_egg_starting_pos()
   assert_equal(egg.sprite.x, display.contentWidth / 2)
   assert_equal(egg.sprite.y, -40)
end

