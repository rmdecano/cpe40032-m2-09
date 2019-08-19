
PipePair = Class{}
local GAP_HEIGHT = math.random(60,120)

function PipePair:init(y)
    self.scored = false
    self.x = VIRTUAL_WIDTH + 32
    self.y = y
    math.randomseed(os.time())
    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + math.random(GAP_HEIGHT-5,GAP_HEIGHT+30))
    }
    self.remove = false
end

function PipePair:update(dt)

    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
end

function PipePair:render()
    for l, pipe in pairs(self.pipes) do
        pipe:render()
    end
end