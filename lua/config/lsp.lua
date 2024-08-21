-- Anything LSP related to go in here
local nvim_lsp = nvim_lsp -- composer global require php-stubs/wordpress-globals php-stubs/wordpress-stubs php-stubs/woocommerce-stubs php-stubs/acf-pro-stubs wpsyntex/polylang-stubs php-stubs/genesis-stubs php-stubs/wp-cli-stubs
local lspconfig = require("lspconfig")

vim.lsp.set_log_level("off")

local on_attach = function(client, bufnr)
  if not vim.lsp.completion then
    return
  end

  vim.lsp.completion.enable(true, client, bufnr, { autotrigger = true })
  require("lsp_signature").on_attach({
    bind = true,
    floating_window = true,
    handler_opts = {
      border = "rounded",
    },
  })

  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", {
      clear = false,
    })

    vim.api.nvim_clear_autocmds({
      buffer = bufnr,
      group = "lsp_document_highlight",
    })

    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd("CursorMoved", {
      group = "lsp_document_highlight",
      buffer = bufnr,
      callback = vim.lsp.buf.clear_references,
    })
  end
end

lspconfig.intelephense.setup({
  on_attach = on_attach,
  stubs = {
    "wordpress",
    "woocommerce",
    "acf-pro",
    "wordpress-globals",
    "wp-cli",
  },
})

local phpactor_capabilities = vim.lsp.protocol.make_client_capabilities()
phpactor_capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
phpactor_capabilities["textDocument"]["codeAction"] = {}

lspconfig.phpactor.setup({
  on_attach = on_attach,
  capabilities = phpactor_capabilities,
  settings = {
    stubs = {
      "bcmath",
      "bz2",
      "Core",
      "curl",
      "date",
      "dom",
      "fileinfo",
      "filter",
      "gd",
      "gettext",
      "hash",
      "iconv",
      "imap",
      "intl",
      "json",
      "libxml",
      "mbstring",
      "mcrypt",
      "mysql",
      "mysqli",
      "password",
      "pcntl",
      "pcre",
      "PDO",
      "pdo_mysql",
      "Phar",
      "readline",
      "regex",
      "session",
      "SimpleXML",
      "sockets",
      "sodium",
      "standard",
      "superglobals",
      "tokenizer",
      "xml",
      "xdebug",
      "xmlreader",
      "xmlwriter",
      "yaml",
      "zip",
      "zlib",
      "wordpress-stubs",
      "woocommerce-stubs",
      "acf-pro-stubs",
      "wordpress-globals",
      "wp-cli-stubs",
      "genesis-stubs",
      "polylang-stubs",
    },
  },
})

return {
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },
  { import = "lazyvim.plugins.extras.lang.json" },

  {
    "onsails/lspkind-nvim",
  },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "php",
        "css",
        "scss",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },

  -- Add inteliphense to lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        intelephense = {
          on_attach = on_attach,
          stubs = {
            "wordpress",
            "woocommerce",
            "acf-pro",
            "wordpress-globals",
            "wp-cli",
          },
        },
      },
    },
  },

  -- Add phpactor to lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- phpactor will be automatically installed with mason and loaded with lspconfig
        phpactor = {
          on_attach = on_attach,
          settings = {
            stubs = {
              "bcmath",
              "bz2",
              "Core",
              "curl",
              "date",
              "dom",
              "fileinfo",
              "filter",
              "gd",
              "gettext",
              "hash",
              "iconv",
              "imap",
              "intl",
              "json",
              "libxml",
              "mbstring",
              "mcrypt",
              "mysql",
              "mysqli",
              "password",
              "pcntl",
              "pcre",
              "PDO",
              "pdo_mysql",
              "Phar",
              "readline",
              "regex",
              "session",
              "SimpleXML",
              "sockets",
              "sodium",
              "standard",
              "superglobals",
              "tokenizer",
              "xml",
              "xdebug",
              "xmlreader",
              "xmlwriter",
              "yaml",
              "zip",
              "zlib",
              "wordpress-stubs",
              "woocommerce-stubs",
              "acf-pro-stubs",
              "wordpress-globals",
              "wp-cli-stubs",
              "genesis-stubs",
              "polylang-stubs",
            },
          },
        },
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
