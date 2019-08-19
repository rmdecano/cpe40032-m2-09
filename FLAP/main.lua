
push = require 'push'

Class = require 'class'

require 'StateMachine'

require 'states/BaseState'
require 'states/CountdownState'
require 'states/PlayState'
require 'states/ScoreState'
require 'states/PauseState'
require 'states/TitleScreenState'


require 'Bird'
require 'Pipe'
require 'PipePair'
require 'Medal'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

local background = love.graphics.newImage('background.png')
local backgroundScroll = 0

local ground = love.graphics.newImage('ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 30
local GROUND_SCROLL_SPEED = 60

local BACKGROUND_LOOPING_POINT = 413

local timer = 0
local pipePairs ={}
local scrolling = true


function love.load()

    love.graphics.setDefaultFilter('nearest', 'nearest')
    
    math.randomseed(os.time())
    love.window.setTitle('Flappy Flappy Bird')

    smallFont = love.graphics.newFont('font.ttf', 8)
    mediumFont = love.graphics.newFont('Love Letters.ttf', 20)
    flappyFont = love.graphics.newFont('BURNSTOW.ttf', 58)
    hugeFont = love.graphics.newFont('Love Letters.ttf', 56)
    love.graphics.setFont(flappyFont)

    sounds = {
        ['jump'] = love.audio.newSource('jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('hurt.wav', 'static'),
        ['score'] = love.audio.newSource('score.wav', 'static'),

        ['music'] = love.audio.newSource('marios_way.mp3', 'static')
    }

    sounds['music']:setLooping(true)
    sounds['music']:play()
    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    gStateMachine = StateMachine {
        ['title'] = function() return TitleScreenState() end,
        ['countdown'] = function() return CountdownState() end,
        ['play'] = function() return PlayState() end,
        ['pause'] = function() return PauseState() end,
        ['score'] = function() return ScoreState() end
       
    }
    gStateMachine:change('title')

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed ={}
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.keypressed(key)

    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end

end

function love.mousepressed(x,y,button)
    love.mouse.buttonsPressed[button] = true
end
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[buttton]
end 

function love.keyboard.wasPressed(key)
    if love.keyboard.keysPressed[key] then 
        return true
    else 
        return false
    end
end

function love.update(dt)
    if scrolling then
        backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
        groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH
    end

    gStateMachine:update(dt)

    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed ={}

end

function love.draw()
    push:start()
    
    love.graphics.draw(background, -backgroundScroll, 0)
    gStateMachine:render()
    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)
    
    push:finish()
end