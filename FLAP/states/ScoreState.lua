
ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    if self.score >= 10 and self.score <= 19 then
        medal = Medal ('Good.png')
        medal:render()
    elseif self.score >= 20 and self.score <= 29 then
        medal = Medal ('Better.png')
        medal:render()
    elseif self.score >= 30 then
        medal = Medal ('Best.png')
        medal:render()
    end 

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 30, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 90, VIRTUAL_WIDTH, 'center')

    love.graphics.printf('Press Enter to Play Again!', 0, 200, VIRTUAL_WIDTH, 'center')
end