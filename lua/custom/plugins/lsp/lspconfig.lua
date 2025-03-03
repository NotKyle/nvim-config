local function read_license_key()
  local key_file = vim.fn.expand '~/.intelephense.key'
  local file = io.open(key_file, 'r')

  if file then
    local key = file:read '*l' -- Read first line
    file:close()
    return key
  end
  return nil
end

return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = { 'lua', 'php', 'javascript', 'html', 'css', 'scss' }, -- Add your required languages here
        auto_install = true, -- Automatically install missing parsers
        highlight = { enable = true },
      }
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = { 'saghen/blink.cmp' },
    config = function()
      require('lspconfig').ts_ls.setup {}
      require('lspconfig').jsonls.setup {}
      require('lspconfig').gopls.setup {}
      require('lspconfig').sqls.setup {}

      require('lspconfig').cssls.setup {}
      require('lspconfig').somesass_ls.setup {}
      require('lspconfig').css_variables.setup {}
      require('lspconfig').lua_ls.setup {}

      require('lspconfig').html.setup {}
      -- require('lspconfig').htmx.setup {}

      -- require('lspconfig').phpactor.setup {}

      local stubs = {
        'amqp',
        'apache',
        'apcu',
        'bcmath',
        'blackfire',
        'bz2',
        'calendar',
        'cassandra',
        'com_dotnet',
        'Core',
        'couchbase',
        'crypto',
        'ctype',
        'cubrid',
        'curl',
        'date',
        'dba',
        'decimal',
        'dom',
        'ds',
        'enchant',
        'Ev',
        'event',
        'exif',
        'fann',
        'FFI',
        'ffmpeg',
        'fileinfo',
        'filter',
        'fpm',
        'ftp',
        'gd',
        'gearman',
        'geoip',
        'geos',
        'gettext',
        'gmagick',
        'gmp',
        'gnupg',
        'grpc',
        'hash',
        'http',
        'ibm_db2',
        'iconv',
        'igbinary',
        'imagick',
        'imap',
        'inotify',
        'interbase',
        'intl',
        'json',
        'judy',
        'ldap',
        'leveldb',
        'libevent',
        'libsodium',
        'libxml',
        'lua',
        'lzf',
        'mailparse',
        'mapscript',
        'mbstring',
        'mcrypt',
        'memcache',
        'memcached',
        'meminfo',
        'meta',
        'ming',
        'mongo',
        'mongodb',
        'mosquitto-php',
        'mqseries',
        'msgpack',
        'mssql',
        'mysql',
        'mysql_xdevapi',
        'mysqli',
        'ncurses',
        'newrelic',
        'oauth',
        'oci8',
        'odbc',
        'openssl',
        'parallel',
        'Parle',
        'pcntl',
        'pcov',
        'pcre',
        'pdflib',
        'PDO',
        'pdo_ibm',
        'pdo_mysql',
        'pdo_pgsql',
        'pdo_sqlite',
        'pgsql',
        'Phar',
        'phpdbg',
        'posix',
        'pspell',
        'pthreads',
        'radius',
        'rar',
        'rdkafka',
        'readline',
        'recode',
        'redis',
        'Reflection',
        'regex',
        'rpminfo',
        'rrd',
        'SaxonC',
        'session',
        'shmop',
        'SimpleXML',
        'snmp',
        'soap',
        'sockets',
        'sodium',
        'solr',
        'SPL',
        'SplType',
        'SQLite',
        'sqlite3',
        'sqlsrv',
        'ssh2',
        'standard',
        'stats',
        'stomp',
        'suhosin',
        'superglobals',
        'svn',
        'sybase',
        'sync',
        'sysvmsg',
        'sysvsem',
        'sysvshm',
        'tidy',
        'tokenizer',
        'uopz',
        'uv',
        'v8js',
        'wddx',
        'win32service',
        'winbinder',
        'wincache',
        'wordpress',
        'xcache',
        'xdebug',
        'xhprof',
        'xml',
        'xmlreader',
        'xmlrpc',
        'xmlwriter',
        'xsl',
        'xxtea',
        'yaf',
        'yaml',
        'yar',
        'zend',
        'Zend OPcache',
        'ZendCache',
        'ZendDebugger',
        'ZendUtils',
        'zip',
        'zlib',
        'zmq',
        'zookeeper',
      }

      require('lspconfig').intelephense.setup {
        settings = {
          intelephense = {
            licenseKey = read_license_key(), -- Dynamically load the key
            files = {
              maxSize = 1000000, -- Reduce max file size for indexing
            },
            storagePath = '/tmp/intelephense', -- Avoid bloating the home directory
            stubs = stubs,
          },
        },
      }

      require('lspconfig').eslint.setup {}
    end,
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'jose-elias-alvarez/typescript.nvim',
      init = function()
        -- require('lazyvim.util').lsp.on_attach(function(_, buffer)
        --   -- stylua: ignore
        --   vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
        --   vim.keymap.set('n', '<leader>cR', 'TypescriptRenameFile', { desc = 'Rename File', buffer = buffer })
        -- end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- ts_ls will be automatically installed with mason and loaded with lspconfig
        ts_ls = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        ts_ls = function(_, opts)
          require('typescript').setup { server = opts }
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },
}
