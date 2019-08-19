PauseState = Class{__includes = BaseState}

function PauseState:enter(params)
    self.bird = params.bird 
    self.pipePairs = params.pipePairs
    self.lastY = params.lastY
    self.timer = params.timer
    self.score = params.score
end

function PauseState:update(dt)
    if love.keyboard.wasPressed('p') then 
        gStateMachine:change('play',{
            bird = self.bird ,
            pipePairs = self.pipePairs,
            lastY = self.lastY,
            timer = self.timer,
            score = self.score
        })
    end
end

function PauseState:render()
    for k,pair in pairs(self.pipePairs) do 
        pair:render()
    end
    self.bird:render()
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Press P to Resume Game', 0, 120, VIRTUAL_WIDTH, 'center')
end