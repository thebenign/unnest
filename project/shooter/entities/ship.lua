local ship = chain.register()

ship:has("control", "sprite", "position", "velocity", "label", "particle", "geometry", "timer", "collider")

ship.position:set(200, 200)

local rect = ship.geometry:new("rectangle")

rect:set(50,50,25,25, 0)

local body_collider = ship.collider:using(rect)

body_collider.call = function()
    --ship.velocity.fric = .05
end

chain.camera.follow(ship)

ship.sprite:set(chain.image.blue_ship, 50)
ship.sprite:setOrigin("center")
ship.sprite:setScale(.5, .5)

ship.velocity.max = 5
ship.velocity.fric = .05

--[[local debug_label = ship.label("confetti ship")
debug_label:setWidth(140)
debug_label.x = -30
debug_label.y = -90
]]
local part = ship.particle:newSystem(200,200)
part:follow(ship)
part:set({spread = math.rad(3), a = math.pi})
part.spread = math.rad(30)
part.min_s = 1
part.max_s = 2
part.lt = 15
part.dist = 25
part.scale = .3
part.rot_s = 0.1
part.fric = .1
part.hsl = {150, 255, 170, 255}
part.pps = 2
part.run = false

local bt = ship.timer:new(3)
local can_shoot = true

bt.call = function()
    can_shoot = true
end


ship.control:on("up", function()
        ship.velocity:add(ship.position.a, .2)
        part.run = true
    end
)

ship.control:onRelease("up", function()
        part.run = false
    end
)

ship.control:on("left", function()
        ship.position.a = ship.position.a - math.rad(6)
    end
)

ship.control:on("right", function()
        ship.position.a = ship.position.a + math.rad(6)
    end
)

ship.control:on("a", function()
        if can_shoot then
            local bullet = ship:newChild("bullet")

            
            can_shoot = false
            bt:start()
        end

    end
)


function ship.update()
    rect.r = ship.position.a
    --part.hsl[1] = math.random()*255
    part.a = ship.position.a-math.pi
    --ship.velocity.fric = 0
    
end

return ship
