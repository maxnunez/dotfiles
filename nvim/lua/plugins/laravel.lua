return {
  "adalessa/laravel.nvim",
  dependencies = {
    "saghen/blink.compat",
  },
  event = { "BufReadPre *.php" },
  opts = {
    features = {
      routes = true,
      models = true,
      artisan = true,
      composer = true,
      tinker = true,
    },
  },
  config = function(_, opts)
    require("laravel").setup(opts)

    -- Registrar fuente de completado para blink.cmp
    local ok, blink = pcall(require, "blink.cmp")
    if ok then
      blink.setup({
        sources = {
          compat = { "laravel" },
          providers = {
            laravel = {
              name = "laravel",
              module = "blink.compat.source",
              score_offset = 95,
            },
          },
        },
      })
    end
  end,
}
