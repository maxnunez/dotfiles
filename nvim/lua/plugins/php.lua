return {
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        intelephense = {
          settings = {
            intelephense = {
              files = {
                maxSize = 5000000,
              },
              stubs = {
                "apache",
                "bcmath",
                "bz2",
                "calendar",
                "Core",
                "curl",
                "date",
                "dom",
                "fileinfo",
                "filter",
                "ftp",
                "gd",
                "hash",
                "iconv",
                "imagick",
                "intl",
                "json",
                "libxml",
                "mbstring",
                "openssl",
                "pcntl",
                "pcre",
                "PDO",
                "pdo_mysql",
                "Phar",
                "readline",
                "Reflection",
                "session",
                "SimpleXML",
                "soap",
                "sockets",
                "sodium",
                "standard",
                "xml",
                "xmlreader",
                "xmlwriter",
                "zip",
                "zlib",
                "wordpress",
                "woocommerce",
              },
              environment = {
                includePaths = {
                  -- WordPress + WooCommerce stubs globales
                  vim.fn.expand("~/.config/composer/vendor/php-stubs/wordpress-stubs"),
                  vim.fn.expand("~/.config/composer/vendor/php-stubs/woocommerce-stubs"),
                },
              },
              diagnosis = {
                enable = true,
                run = "onType",
              },
              formatting = {
                enable = true,
              },
              completion = {
                enable = true,
                fullyQualifyGlobalConstantsAndFunctions = false,
                triggerParameterHints = true,
              },
            },
          },
        },
      },
    },
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}
      opts.formatters_by_ft.php = { "pint", "phpcbf" }
      opts.formatters_by_ft.blade = opts.formatters_by_ft.blade or { "blade-formatter" }
    end,
  },
}
