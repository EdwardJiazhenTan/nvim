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
        "tailwindcss",
        "gopls",
        "bashls",
      },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")

    -- TypeScript/JavaScript Language Server
    lspconfig.ts_ls.setup({})

    -- Tailwind CSS Language Server
    lspconfig.tailwindcss.setup({
      filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte" },
      settings = {
        tailwindCSS = {
          classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning"
          },
          validate = true
        }
      }
    })

    -- ESLint Language Server (only for projects with config files)
    lspconfig.eslint.setup({
      settings = {
        workingDirectories = { mode = "auto" },
        codeActionOnSave = {
          enable = true,
          mode = "all"
        },
        format = true,
        quiet = false,
        onIgnoredFiles = "off"
      },
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
      root_dir = function(fname)
        -- Only activate if config files exist (no fallback)
        return lspconfig.util.root_pattern(
          "eslint.config.js",
          "eslint.config.mjs",
          "eslint.config.cjs",
          ".eslintrc.js",
          ".eslintrc.json",
          ".eslintrc",
          "package.json"
        )(fname)
      end,
    })

  end,
}
