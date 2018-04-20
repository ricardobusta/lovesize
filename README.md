# lovesize
Keeps the game screen size and aspect ratio constant when resizing window.
Makes it easier to work with a fixed resolution.

how to use:

```lua
-- Pass desired resolution (can be called again to change it)
function love.load()
    lovesize.set(800, 600)
    
    -- Enable screen resizing (optional)
    local flags = {}
    flags.resizable = true
    love.window.setMode(lovesize.getWidth(), lovesize.getHeight(), flags)
end

-- Necessary to keep the correct values up to date
function love.resize(width, height)
    lovesize.resize(width, height)
end

-- How to draw stuff 
function love.draw()
    -- Example how to clear the letterboxes with a white color
    love.graphics.clear(255,255,255)

    lovesize.begin()
    -- Draw your game stuff here
    lovesize.finish()

    -- Draw stuff using screen coords here
end

-- Example how to use "inside" and "pos" functions:
function love.mousepressed(x, y, button, istouch)
    local circle = {}
    if lovesize.inside(x, y) then
        circle.x, circle.y = lovesize.pos(x, y)
        table.insert(circles, circle)
    end
end
```