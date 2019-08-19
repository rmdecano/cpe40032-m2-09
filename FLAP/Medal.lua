Medal =Class {}

function Medal:init(img)
    self.image = love.graphics.newImage(img)
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH /2
    self.y = VIRTUAL_HEIGHT /2
end

function Medal:render()
    love.graphics.draw(self.image, VIRTUAL_WIDTH/2 -30, VIRTUAL_HEIGHT/2 -30)
end