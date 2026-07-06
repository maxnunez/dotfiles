-- Java development setup
-- JDK 21 + jdtls (Eclipse JDT Language Server) via Mason

return {
  -- jdtls config via nvim-lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        jdtls = {
          -- jdtls se instala via Mason automáticamente
          settings = {
            java = {
              -- JDK 21 instalado via apt
              home = "/usr/lib/jvm/java-21-openjdk-amd64",
              configuration = {
                runtimes = {
                  {
                    name = "JavaSE-21",
                    path = "/usr/lib/jvm/java-21-openjdk-amd64",
                  },
                },
              },
            },
          },
        },
      },
    },
  },
}
