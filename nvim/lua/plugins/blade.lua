return {
  -- Syntax highlighting para Blade
  {
    "jwalton512/vim-blade",
    lazy = false,
  },
  -- Formatear .blade.php con blade-formatter
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft["blade"] = { "blade-formatter" }
    end,
  },
}
