-- Catppuccin Macchiato Bubbles config for lualine
return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    -- Catppuccin Macchiato colors
    local colors = {
      blue     = '#8aadf4', -- catppuccin blue
      cyan     = '#91d7e3', -- catppuccin sky
      black    = '#1e2030', -- catppuccin base
      white    = '#cad3f5', -- catppuccin text
      red      = '#ed8796', -- catppuccin red
      violet   = '#c6a0f6', -- catppuccin mauve
      grey     = '#363a4f', -- catppuccin surface0
      green    = '#a6da95', -- catppuccin green
      peach    = '#f5a97f', -- catppuccin peach
      surface1 = '#494d64', -- catppuccin surface1
    }

    local bubbles_theme = {
      normal = {
        a = { fg = colors.black, bg = colors.blue },
        b = { fg = colors.white, bg = colors.grey },
        c = { fg = colors.white },
      },
      insert = { a = { fg = colors.black, bg = colors.white } },
      visual = { a = { fg = colors.black, bg = colors.cyan } },
      replace = { a = { fg = colors.black, bg = colors.red } },
      command = { a = { fg = colors.black, bg = colors.surface1 } },
      inactive = {
        a = { fg = colors.white, bg = colors.surface1 },
        b = { fg = colors.white, bg = colors.surface1 },
        c = { fg = colors.white },
      },
    }

    require('lualine').setup {
      options = {
        theme = bubbles_theme,
        component_separators = '',
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = {
          { 'mode', separator = { left = '' }, right_padding = 2 }
        },
        lualine_b = { 'branch' },
        lualine_c = {},

        lualine_x = {
        },
        lualine_y = { 'diff' },
        lualine_z = {
          { 'hostname', separator = { right = '' }, left_padding = 2 },
        },
      },
      inactive_sections = {
        lualine_a = { 'filename' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {
        },
      },
      extensions = { 'aerial' }
    }
  end
}
