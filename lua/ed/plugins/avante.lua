-- Plugin specification for loading the local development version of avante.nvim
-- Save this as ~/.config/nvim/lua/plugins/avante-dev.lua

return {
  -- Local development version of avante.nvim
  {
    dir = "/home/ed/Documents/avante.nvim", -- Path to your local development copy
    name = "avante-popup.nvim",             -- Custom name to differentiate from original
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "echasnovski/mini.pick",         -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp",              -- autocompletion for avante commands and mentions
      "nvim-tree/nvim-web-devicons",   -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true, -- required for Windows users
          },
        },
      },
      {
        'MeanderingProgrammer/render-markdown.nvim',
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
    build = "make", -- Build the project
    config = function()
      require("avante").setup({
        ui = {
          mode = "popup",                        -- Default to popup mode
        },
        provider = "openai",                     -- Change to your preferred provider
        openai = {
          endpoint = "http://localhost:1234/v1", -- Local LM Studio endpoint
          model = "local-model",                 -- Model name doesn't matter for local API
          timeout = 30000,
          temperature = 0.7,
        },
        windows = {
          popup = {
            width = 0.8,
            height = 0.8,
            border = "rounded",
          },
        },
      })
    end,
    -- Disable the original avante.nvim if it's loaded elsewhere
    init = function()
      -- Check if original avante.nvim is loaded and disable it
      if package.loaded["avante"] then
        vim.notify("Warning: Both original avante.nvim and development version are loaded.", vim.log.levels.WARN)
      end
    end,
  },

  -- Explicitly disable the original avante.nvim if it's in your config
  {
    "yetone/avante.nvim",
    enabled = false, -- Disable the original plugin
  },
}
