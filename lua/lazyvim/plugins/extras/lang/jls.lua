if lazyvim_docs then
  -- nvim-jls configuration options (set via opts on "idelice/nvim-jls"):
  --   jls_dir = nil                    -- path to a custom JLS install dir; nil = auto (mason > managed)
  --   inlay_hints = { enabled = false} -- parameter name hints at call sites (off by default)
  --   auto_restart = false             -- automatically restart JLS on crash (up to 3 attempts with backoff)
  --   jvm_args = nil                   -- override default JVM heap args (-Xmx2g -Xms512m …)
  --   settings = {}                    -- raw LSP settings payload forwarded to JLS
  -- JLS is installed automatically via mason. For a mason-free setup, run :JlsInstall instead.
  --
  -- ## Debugging
  --
  -- JLS ships a DAP debug adapter (`jls-debug-adapter`) that attaches to a JVM via JDWP.
  -- This extra configures it automatically. To use it:
  --
  -- 1. Start your Java application with JDWP enabled (port 5005):
  --
  --    Maven:   ./mvnw spring-boot:run \
  --               -Dspring-boot.run.jvmArguments="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"
  --    Gradle:  ./gradlew bootRun --debug-jvm
  --    JAR:     java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005 -jar app.jar
  --
  -- 2. Open Neovim from the project root (so sourceRoots resolves to src/main/java automatically).
  --    If your sources are elsewhere, set SOURCE_ROOT=/path/to/src/main/java before launching Neovim.
  --
  -- 3. Press `<leader>dc` and select "Debug (Attach) - Remote (JLS)".
  --
  -- Set breakpoints with `<leader>db` before or after attaching.
end

return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "java",
      root = {
        "build.gradle",
        "build.gradle.kts",
        "build.xml", -- Ant
        "pom.xml", -- Maven
        "settings.gradle", -- Gradle
        "settings.gradle.kts", -- Gradle
        "WORKSPACE",
        "WORKSPACE.bazel",
        ".java-version",
      },
    })
  end,

  -- Add java to treesitter.
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "java" } },
  },

  -- Ensure JLS binary is installed via mason.
  -- nvim-jls automatically resolves the mason install path at startup.
  {
    "mason-org/mason.nvim",
    optional = true,
    opts = { ensure_installed = { "jls" } },
  },

  -- Disable nvim-jdtls when jls extra is enabled.
  {
    "mfussenegger/nvim-jdtls",
    optional = true,
    enabled = false,
  },

  -- Disable jdtls in lspconfig and prevent mason from installing it.
  -- Table opts deep-merge cleanly, so this is order-independent regardless
  -- of whether lang.java is also enabled.
  -- jls is registered in nvim-lspconfig. nvim-jls calls lspconfig.jls.setup() from
  -- its ftplugin, so we do not add jls to servers here — nvim-jls owns the client
  -- lifecycle and passes its own root detection, on_attach, and settings through.
  -- WARNING: do not add `servers = { jls = {} }` to your lspconfig opts.
  -- Doing so causes lspconfig to start a default jls client before nvim-jls
  -- can apply its configuration; lspconfig will then reuse that bare client
  -- for all buffers in the project, ignoring nvim-jls opts entirely.
  {
    "neovim/nvim-lspconfig",
    optional = true,
    opts = {
      servers = {
        jdtls = { enabled = false, mason = false },
      },
    },
  },

  -- Configure the JLS debug adapter (installed alongside the LSP binary by mason).
  -- The adapter communicates via stdio and attaches to a JVM running with JDWP.
  -- Start your JVM with: -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005
  {
    "mfussenegger/nvim-dap",
    optional = true,
    opts = function()
      local dap = require("dap")
      dap.adapters.jls = {
        type = "executable",
        command = "jls-debug-adapter",
      }
      dap.configurations.java = dap.configurations.java or {}
      vim.list_extend(dap.configurations.java, {
        {
          type = "jls",
          request = "attach",
          name = "Debug (Attach) - Remote (JLS)",
          hostName = "127.0.0.1",
          port = 5005,
          -- Required by JLS: path(s) to Java source roots.
          -- Defaults to Maven/Gradle standard layout (src/main/java).
          -- Override by setting the SOURCE_ROOT env var before launching Neovim.
          sourceRoots = function()
            local root = os.getenv("SOURCE_ROOT")
            if root and root ~= "" then
              return { root }
            end
            return { vim.fn.getcwd() .. "/src/main/java" }
          end,
        },
      })
    end,
  },

  -- nvim-jls: Neovim client for JLS (Java Language Server).
  -- JLS starts automatically for java buffers via its ftplugin.
  -- JLS binary is installed by mason; nvim-jls resolves the mason path automatically.
  {
    "idelice/nvim-jls",
    main = "jls",
    ft = { "java" },
    opts = {},
  },
}
