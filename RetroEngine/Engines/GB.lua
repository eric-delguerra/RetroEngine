local GB = {
    name = "GB Engine",
    colors = {
        primary = { 155 / 255, 188 / 255, 15 / 255 },
        secondary = { 139 / 255, 172 / 255, 15 / 255 },
        tertiary = { 48 / 255, 98 / 255, 48 / 255 },
        background_dark = { 15 / 255, 56 / 255, 15 / 255 },
        background_light = { 155 / 255, 188 / 255, 15 / 255 },
        black = { 0, 0, 0 },
    },
    mode = {
        width = 160,
        height = 144,
        scale = 3,
    },
    font_size = 16,
    font_name = 'pixel',
    boot = {
        sound = 1,
        image = nil,
        scroll_timer = 3,
        scroll_x = 0,
        scroll_y = 0,
        pause_timer = 2
    }
}

return GB
