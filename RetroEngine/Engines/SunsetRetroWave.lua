local RETRO_WAVE = {
    name = "SUNSET_RETRO_WAVE Engine",
    colors = {
        primary = { 255 / 255, 211 / 255, 25 / 255 },
        secondary = { 255 / 255, 144 / 255, 31 / 255 },
        tertiary = { 255 / 255, 41 / 255, 117 / 255 },
        background_dark = { 199 / 255, 0 / 255, 181 / 255 },
        background_light = { 176 / 255, 0 / 255, 255 / 255 },
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
