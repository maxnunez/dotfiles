-- Python development setup for Flask, Django, FastAPI services
-- Uses globally installed tools via `uv tool` (ruff, basedpyright, debugpy)

return {
  -- LSP config: tell Mason not to manage tools we installed globally via uv
  -- (ruff, basedpyright, debugpy ya están en PATH)
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        basedpyright = {
          mason = false, -- ya instalado globalmente via uv
          settings = {
            basedpyright = {
              analysis = {
                typeCheckingMode = "recommended", -- standard, strict, off, recommended
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
                inlayHints = {
                  parameterTypes = { enabled = true },
                  variableTypes = { enabled = true },
                  functionReturnTypes = { enabled = true },
                },
              },
            },
          },
        },
        ruff = {
          mason = false, -- ya instalado globalmente via uv
          cmd_env = { RUFF_TRACE = "messages" },
          init_options = {
            settings = {
              logLevel = "error",
            },
          },
        },
      },
    },
  },

  -- Ruff como formateador para Python
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft["python"] = { "ruff_format" }
    end,
  },
}
