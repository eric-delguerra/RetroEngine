local RETRO_WAVE = {
    name = "RETRO_WAVE Engine",
    colors = {
        primary = {45 / 255, 226 / 255, 230 / 255},
        secondary = {3 / 255, 94 / 255, 232 / 255},
        tertiary = {246 / 255, 1 / 255, 157 / 255},
        background_dark = {212 / 255, 0 / 255, 120 / 255},
        background_light = {151 / 255, 0 / 255, 204 / 255},
        black = { 0, 0, 0 },
    },
    mode = {
        width = 160,
        height = 144,
        scale = 4,
    },
    font_size = 32,
    font_name = 'pixel',
    boot = {
        sound = 1,
        image = nil,
        scroll_timer = 0,
        scroll_x = 0,
        scroll_y = 0,
        pause_timer = 0
    }
}

return RETRO_WAVE
