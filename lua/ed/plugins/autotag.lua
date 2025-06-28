-- ~/.config/nvim/lua/plugins/ts-autotag.lua
return {
  "windwp/nvim-ts-autotag",
  ft = { "html", "javascriptreact", "typescriptreact", "javascript", "typescript", "vue" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {},   -- 默认即可
}
