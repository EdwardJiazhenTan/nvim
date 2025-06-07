return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      backdrop = 0.95,
      width = 120,
      height = 1,
      options = {
        -- signcolumn = "no",
        -- number = false,
        -- relativenumber = false,
        -- cursorline = false,
        -- cursorcolumn = false,
        -- foldcolumn = "0",
        -- list = false,
      },
    },
    plugins = {
      options = {
        enabled = true,
        ruler = false,
        showcmd = false,
        laststatus = 0,
      },
    },
    on_open = function(win)
      -- Disable linting and auto-suggestions
      vim.lsp.buf_detach_client(vim.api.nvim_get_current_buf(), 0) -- Detaches all LSP clients
      vim.b.cmp_enabled = false                                    -- Disable auto-completion for nvim-cmp
    end,
    on_close = function()
      -- Re-enable linting and auto-suggestions
      vim.lsp.start_client({}) -- Restarts LSP clients (you may need to refine this)
      vim.b.cmp_enabled = true -- Re-enable auto-completion for nvim-cmp
    end,
  },
  config = function()
    require("zen-mode").setup({})
    vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { noremap = true, silent = true, desc = "Toggle Zen Mode" })
  end,
}
