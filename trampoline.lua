require 'class'
local physics = require("physics")

Trampoline = class()

function Trampoline:init(startX, startY, endX, endY)
   self:create(startX, startY, endX, endY)
end

function Trampoline:create(startX, startY, endX, endY)
   local boards = {}
   local joints = {}

   self.pole1 = display.newRect( startX, startY, 0, 0 )
   physics.addBody( self.pole1, "static", { friction=0.5 } )

   self.pole2 = display.newRect( endX, endY, 0, 0 )
   physics.addBody( self.pole2, "static", { friction=0.5 } )

   local distance = math.sqrt((endX - startX) ^ 2 + (endY - startY) ^ 2)

   local boardCount = 10
   self.boardCount = boardCount

   local boardLength = distance / boardCount
   
   local xStep = (endX - startX) / boardCount
   local yStep = (endY - startY) / boardCount

   local jointOffestX = xStep * 0.3
   local jointOffestY = yStep * 0.3

   local x = startX + xStep / 2
   local y = startY + yStep / 2

   local angle = math.atan2(yStep, xStep) * 180 / math.pi
   for j = 1,boardCount do

      local board = display.newImage( "board.png" )
      board.width = boardLength
      board.height = 2
      board.rotation = angle

      board.x = x
      board.y = y

      physics.addBody( board, { density=33, friction=0.1, bounce=0.0 } )
      
      -- damping the board motion increases the "tension" in the bridge
      board.angularDamping = 5000
      board.linearDamping = 0.7

      --create joints between boards
      if (j > 1) then
      	 prevLink = boards[j-1] -- each board is joined with the one before it
	 joints[j] = physics.newJoint( "distance", prevLink, board, prevLink.x + jointOffestX, prevLink.y + jointOffestY,  board.x - jointOffestX, board.y - jointOffestY)
      	 joints[j].length = 1.94
      	 joints[j].frequency = 6
      	 joints[j].dampingRatio  = 0.7
      else
      	 joints[j] = physics.newJoint( "pivot", self.pole1, board, self.pole1.x, self.pole1.y )
      end

      boards[j] = board

      x = x + xStep
      y = y + yStep
   end

   joints[#joints + 1] = physics.newJoint( "pivot", boards[#boards], self.pole2, self.pole2.x, self.pole2.y )

   self.boards = boards
   self.joints = joints
end

function Trampoline:cleanup()
   self.pole1:removeSelf()
   self.pole2:removeSelf()
   
   for i, board in ipairs(self.boards) do
      board:removeSelf()
   end

   for i, joint in ipairs(self.joints) do
      joint:removeSelf()
   end
end

function Trampoline:fadeOut(main)
   self.fadedBoards = 0

   local complete = function() 
      self.fadedBoards = self.fadedBoards + 1
      if self.fadedBoards == self.boardCount then
	 main:removeTrampoline(self)
      end
   end

   for i, board in ipairs(self.boards) do
      transition.to(board, {time=1500, alpha=0 , onComplete=complete})
   end
end