--[[
RetroEngine is a class that represents a retro game engine with boot animations and customizable configurations.

Properties:
- boot_animation_end (boolean): Indicates if the boot animation has ended.
- hasBoot (boolean): Indicates if the boot process has completed.
- boot_speed (number): Speed of the boot animation.
- boot_end_timer (number): Duration of the boot end timer.
- logo (Image): The logo image displayed during boot.
- colors (table): Color configurations for the engine.
- backgroundColor (table): Background color of the engine.
- name (string): Name of the engine.
- mode (table): Display mode configurations.
- font_size (number): Font size used in the engine.
- font_name (string): Font name used in the engine.
- boot (table): Boot animation configurations.
- font (Font): Font object used in the engine.
- sound (Source): Sound object for the boot animation.

Methods:
- RetroEngine:new(pType, pConfig): Creates a new instance of RetroEngine.
- RetroEngine:load(): Loads the engine and initializes the window and graphics settings.
- RetroEngine:init(): Initializes the engine settings and prints loading information.
- RetroEngine:update(dt): Updates the engine state, including the boot animation.
- RetroEngine:draw(): Draws the engine graphics, including the boot animation and background.
- RetroEngine:OpeningScreenBegin(): Draws the opening screen during the boot animation.
- RetroEngine:OpeningScreenEnd(): Draws the ending screen of the boot animation.
- RetroEngine:PrintName(): Prints the engine name and logo on the screen.
- RetroEngine:resize(pNewScale): Resizes the engine display based on the new scale.
- RetroEngine:hasBooted(): Returns whether the engine has completed the boot process.
- RetroEngine:setBackgroundColor(pBg): Sets the background color of the engine.
- RetroEngine:getColors(colorName): Returns the color configuration based on the provided color name or all colors if no name is provided.
- RetroEngine:GetCenterScreen(): Returns the center coordinates of the screen.
- RetroEngine:GetScreenSize(): Returns the size of the screen.

(c) Eric Del Guerra - MIT License
]]
local RetroEngine = {}
RetroEngine.__index = RetroEngine

local DEFAULT_BOOT_X_SPEED = 80
local DEFAULT_BOOT_END_TIMER = 3
local endind_timer = 0

function RetroEngine:new(pType, pConfig)
    pType = pType or 'GB'
    local RE = setmetatable({}, self)

    -- Set default properties
    RE.boot_animation_end = false
    RE.hasBoot = false
    RE.boot_speed = DEFAULT_BOOT_X_SPEED
    RE.boot_end_timer = DEFAULT_BOOT_END_TIMER
    RE.logo = love.graphics.newImage('RetroEngine/Images/logov2.png')

    -- Set all the properties of the engine
    local ENGINE = love.filesystem.load('RetroEngine/Engines/' .. pType .. '.lua')()

    RE.colors = ENGINE.colors
    RE.backgroundColor = ENGINE.colors.background_dark
    RE.name = ENGINE.name
    RE.mode = ENGINE.mode
    RE.font_size = ENGINE.font_size
    RE.font_name = ENGINE.font_name
    RE.boot = ENGINE.boot

    if pConfig then
        for key, value in pairs(pConfig) do
            RE[key] = value
        end
    end

    RE.font = love.graphics.newFont('RetroEngine/Fonts/' .. RE.font_name .. '.ttf', RE.font_size)
    RE.sound = love.audio.newSource('RetroEngine/Sounds/intro_' .. RE.boot.sound .. '.mp3', 'static')
    return RE
end

function RetroEngine:load()
    love.graphics.setDefaultFilter('nearest')
    love.window.setTitle(self.name .. ' - ' .. self.mode.width .. 'x' .. self.mode.height)
    self:init()
end

function RetroEngine:init()
    print('Loading ' .. self.name .. ' Engine up!')
    print('Resolution: ' .. self.mode.width .. 'x' .. self.mode.height)
    love.window.setMode(
        self.mode.width * self.mode.scale,
        self.mode.height * self.mode.scale
    )

    self:setBackgroundColor()
    love.graphics.setFont(self.font)
end

function RetroEngine:update(dt)
    if self.boot_animation_end then
        endind_timer = endind_timer + dt
    end
    if not self.boot_animation_end then
        if self.boot.scroll_x < self.mode.width then
            self.boot.scroll_x = self.boot.scroll_x + self.boot_speed * dt
        else
            love.audio.play(self.sound)
            self.boot_animation_end = true
        end
    end
end

function RetroEngine:draw()
    if not self.boot_animation_end and not self.hasBoot then
        self:OpeningScreenBegin()
    else
        if endind_timer < self.boot_end_timer then
            self:OpeningScreenEnd()
        else
            self.hasBoot = true
        end
    end

    self:setBackgroundColor()
end

-- ----------------------------------------------------------
-- --------------- OPENING SCREEN  --------------------------
-- ----------------------------------------------------------

function RetroEngine:OpeningScreenBegin()
    -- Opening screen text
    self:PrintName()

    -- Opening screen background
    love.graphics.scale(self.mode.scale)
    love.graphics.rectangle(
        'fill',
        self.boot.scroll_x,
        self.boot.scroll_y,
        self.mode.width,
        self.mode.height
    )
end

function RetroEngine:OpeningScreenEnd()
    self:PrintName()
end

function RetroEngine:PrintName()
    local text = self.name
    love.graphics.print(
        text,
        love.graphics.getWidth() / 2,
        love.graphics.getHeight() * .3 + self.boot.scroll_x / 3,
        0,
        1,
        1,
        self.font:getWidth(text) / 2,
        self.font:getHeight() / 2
    )
    love.graphics.draw(
        self.logo,
        love.graphics.getWidth() / 2,
        love.graphics.getHeight() * .45 + self.boot.scroll_x / 3,
        0,
        self.mode.scale / 3,
        self.mode.scale / 3,
        self.logo:getWidth() / 2,
        self.logo:getHeight() / 2
    )
end

-- ----------------------------------------------------------
-- --------------- UTILS FUNCTIONS --------------------------
-- ----------------------------------------------------------

function RetroEngine:resize(pNewScale)
    self.mode.scale = pNewScale
    self:init()
end

function RetroEngine:hasBooted()
    return self.hasBoot
end

function RetroEngine:setBackgroundColor(pBg)
    love.graphics.setBackgroundColor(pBg or self.backgroundColor)
    love.graphics.setColor(self.colors.primary)
end

function RetroEngine:getColors(colorName)
    if colorName then
        return self.colors[colorName]
    else
        return self.colors
    end
end

function RetroEngine:GetCenterScreen()
    return love.graphics.getWidth() * (self.mode.scale / 10),
        love.graphics.getHeight() * (self.mode.scale / 10)
end

function RetroEngine:GetScreenSize()
    return love.graphics.getWidth() * self.mode.scale,
        love.graphics.getHeight() * self.mode.scale
end

return RetroEngine
