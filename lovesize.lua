--[[
    lovesize 0.4 by RicardoBusta
    https://github.com/RicardoBusta/
    https://github.com/RicardoBusta/lovesize

    Tested with love 11.0
]]
local lovesize = {}
local lw, lh = 800, 600 -- lovesize target size
local lx, ly = 0, 0 -- translation required to center the game area
local ls = 1 -- scale to fit the game screen to love screen

-- Set lovesize with the desired width, height and options
function lovesize.set(w, h, options)
    lw = w or lw
    lh = h or lh
    lovesize.resize(love.graphics.getWidth(), love.graphics.getHeight())
end

-- Used to start the lovesize application
function lovesize.begin()
    -- Scissors will keep the game from rendering outside the specified screen. Clean the letterbox before this call.
    love.graphics.push()
    love.graphics.setScissor(lx, ly, love.graphics.getWidth() - 2 * lx, love.graphics.getHeight() - 2 * ly)
    love.graphics.translate(lx, ly)
    love.graphics.scale(ls, ls)
end

-- Used to finish the lovesize application
function lovesize.finish()
    love.graphics.setScissor()
    love.graphics.pop()
end

-- Used to calculate the values used by lovesize
function lovesize.resize(width, height)
    local sx = width / lw
    local sy = height / lh

    -- Check which size scales the most, and add letterbox space to it
    if sx > sy then
        ls = sy 
        lx, ly = (width - lw * ls) / 2, 0
    else
        ls = sx
        lx, ly = 0, (height - lh * ls) / 2
    end
end

-- Transforms the x,y coordinates to the game world position
function lovesize.pos(x, y)
    local is = 1 / ls
    return math.floor((x - lx) * is), math.floor((y - ly) * is)
end

-- Checks if the coordinate is inside the screen
function lovesize.inside(x, y)
    return x >= lx and x < love.graphics.getWidth() - lx and y >= ly and y < love.graphics.getHeight() - ly
end

function lovesize.getWidth()
    return lw
end
   
function lovesize.getHeight()
    return lh
end

return lovesize
