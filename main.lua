coins = {}
spawnTimer = 0
spawnInterval = 0.3
score = 0
  function love.load()
     for i = 1, 10 do
        spawnCoin()
    end
  love.window.setTitle("Magnet!")
  magnet = love.graphics.newImage("magnet.png")
  coin = love.graphics.newImage("coin.png")
    rect = {
      x = 100,
      y = 100,
      width = magnet:getWidth() * 0.15,
      height = magnet:getHeight() * 0.15,
      dragging = { active = false, diffX = 0, diffY = 0 }
    }
  end
  function love.draw()
    love.graphics.print("Score: " .. score, 10, 10)
    love.graphics.draw(magnet, rect.x, rect.y ,0 ,0.15 ,0.15)
        for _, c in ipairs(coins) do
        love.graphics.draw(coin, c.x, c.y, 0, 0.2, 0.2)
    end
  end


   
  function love.mousepressed(x, y, button)
    if button == 1
    and x > rect.x and x < rect.x + rect.width
    and y > rect.y and y < rect.y + rect.height
    then  
      rect.dragging.active = true
      rect.dragging.diffX = x - rect.x
      rect.dragging.diffY = y - rect.y
    end
  end
  function love.mousereleased(x, y, button)
    if button == 1 then
        rect.dragging.active = false
    end
  end

function love.update(dt)
  spawnTimer = spawnTimer + dt

if spawnTimer >= spawnInterval then
    spawnCoin()
    spawnTimer = 0
end
    if rect.dragging.active then
        rect.x = love.mouse.getX() - rect.dragging.diffX
        rect.y = love.mouse.getY() - rect.dragging.diffY
    end

    for i = #coins, 1, -1 do
        local c = coins[i]

        local dx = rect.x - c.x
        local dy = rect.y - c.y

        local dist = math.sqrt(dx*dx + dy*dy)

        local force = 200

        if dist < 200 then
            c.x = c.x + dx * dt * force / dist
            c.y = c.y + dy * dt * force / dist
        end

        if dist < 20 then
            table.remove(coins, i)
                score = score + 1
        end
    end
end

function spawnCoin()
    local w, h = love.graphics.getDimensions()

    table.insert(coins, {
        x = math.random(0, w - 32),
        y = math.random(0, h - 32)
    })
end
