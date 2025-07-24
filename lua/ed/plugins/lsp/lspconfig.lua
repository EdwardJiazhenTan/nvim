return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim",          build = ":MasonUpdate" },
    { "williamboman/mason-lspconfig.nvim" },
  },
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls",
        "tailwindcss", -- 正确的 mason 包名
        "eslint",      -- 正确的 mason 包名
        "pylsp",
        "jdtls",
        "bashls",
        "lua_ls",
      },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")

    -- TypeScript/JavaScript Language Server
    lspconfig.ts_ls.setup({})

    -- Tailwind CSS Language Server
    lspconfig.tailwindcss.setup({
      filetypes = {
        "html",
        "css",
        "scss",
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
        "svelte",
        "astro",
        "php",
        "markdown",
      },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              -- 支持更多的 class 匹配模式
              "class[:]\\s*['\"`]([^'\"`]*)['\"`]",
              "class[:]\\s*[{]([^}]*)[}]",
              "tw[`]([^`]*)[`]",
              "tw\\.\\w+[`]([^`]*)[`]",
              "tw\\(.*?\\)[`]([^`]*)[`]",
              { "clsx\\(([^)]*)\\)",       "(?:'|\"|`)([^']*)(?:'|\"|`)" },
              { "classnames\\(([^)]*)\\)", "'([^']*)'" },
              { "cva\\(([^)]*)\\)",        "[\"'`]([^\"'`]*).*?[\"'`]" },
              { "cn\\(([^)]*)\\)",         "(?:'|\"|`)([^'\"`]*)(?:'|\"|`)" },
            },
          },
          validate = true,
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
          },
        },
      },
      root_dir = function(fname)
        return require("lspconfig.util").root_pattern(
          "tailwind.config.js",
          "tailwind.config.cjs",
          "tailwind.config.mjs",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.cjs",
          "postcss.config.mjs",
          "postcss.config.ts",
          "package.json",
          "node_modules",
          ".git"
        )(fname)
      end,
    })

    -- ESLint Language Server
    lspconfig.eslint.setup({
      settings = {
        workingDirectories = { mode = "auto" },
      },
    })

    -- Python Language Server
    lspconfig.pylsp.setup({})

    -- Java Language Server
    lspconfig.jdtls.setup({})

    -- Bash Language Server
    lspconfig.bashls.setup({})

    -- Lua Language Server
    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    })
  end,
}
