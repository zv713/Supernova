--- Load required modules -- 
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local myApp = require( "myApp" ) 

-- execute when scene is launched
function scene:createScene( event )
        local group = self.view
        
        --variable decrelations
		local centerX = display.contentCenterX
		local centerY = display.contentCenterY
		local page = 1
		
		--instruction slide
		local bg = display.newImageRect( group, "images/help/help" .. page .. ".png", display.contentWidth, display.contentHeight )
		bg.x = centerX
		bg.y = centerY
		
		local function nextPage( event )
			if event.phase == "ended" then
				if page < 5 then
					page = page + 1
					bg:removeSelf()
					bg = nil
					bg = display.newImageRect( group, "images/help/help" .. page .. ".png", display.contentWidth, display.contentHeight )
					bg.x = centerX
					bg.y = centerY
					bg:addEventListener ( "touch", nextPage )
				else
					-- finish instructions, so go back to game and save seenInstructions variable
					myApp.settings.seenInstructions = true
					myApp.saveTable(myApp.settings, "settings.json")
					timer.performWithDelay ( 100, function() storyboard.gotoScene ( "level1" ) end, 1 )
				end
			end
		end
		
		--add touch listener
		bg:addEventListener ( "touch", nextPage )
		
end

function scene:enterScene( event )
        local group = self.view

end

function scene:exitScene( event )
        local group = self.view
end

function scene:destroyScene( event )
        local group = self.view

end


---------------------------------------------------------------------------------
-- END OF IMPLEMENTATION
---------------------------------------------------------------------------------

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene