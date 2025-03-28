local api = vim.api
local fn = vim.fn
local o = vim.o

-- Lite mode toggle
local lite = true

local function restore_cursor_position()
  api.nvim_create_autocmd('BufReadPost', {
    callback = function(args)
      local mark = api.nvim_buf_get_mark(args.buf, '"')
      local line_count = api.nvim_buf_line_count(args.buf)
      if mark[1] > 0 and mark[1] <= line_count then
        vim.cmd 'normal! g`"zz'
      end
    end,
  })
end

local function remove_trailing_whitespace()
  api.nvim_create_autocmd('BufWritePre', {
    callback = function()
      local save_cursor = fn.getpos '.'
      vim.cmd [[%s/\s\+$//e]]
      fn.setpos('.', save_cursor)
    end,
  })
end

local function highlight_yank()
  api.nvim_create_autocmd('TextYankPost', {
    callback = function()
      vim.highlight.on_yank { higroup = 'IncSearch', timeout = 40 }
    end,
  })
end

local function auto_resize_splits()
  api.nvim_create_autocmd('VimResized', {
    command = 'wincmd =',
  })
end

local function setup_lsp_autocmds()
  if lite then
    api.nvim_create_autocmd('LspAttach', {
      group = api.nvim_create_augroup('UserLspConfig', {}),
      callback = function()
        for _, client in pairs(vim.lsp.get_clients {}) do
          if client.name == 'tailwindcss' then
            client.server_capabilities.completionProvider.triggerCharacters = { '"', "'", '`', '.', '(', '[', '!', '/', ':' }
          end
        end
      end,
    })
  end
end

local function setup_terminal_autocmds()
  api.nvim_create_autocmd('TermOpen', {
    callback = function()
      local is_terminal = api.nvim_get_option_value('buftype', { buf = 0 }) == 'terminal'
      o.number = not is_terminal
      o.relativenumber = not is_terminal
      o.signcolumn = is_terminal and 'no' or 'yes'
    end,
  })
end

local function setup_project_root()
  api.nvim_create_autocmd('BufWinEnter', {
    group = api.nvim_create_augroup('auto-project-root', {}),
    callback = function(args)
      if api.nvim_get_option_value('buftype', { buf = args.buf }) ~= '' then
        return
      end

      local root = vim.fs.root(args.buf, function(name, path)
        local patterns = { '.git', 'Cargo.toml', 'go.mod', 'build/compile_commands.json' }
        return vim.iter(patterns):any(function(filepat)
          return filepat == name
        end)
      end)

      if root then
        vim.cmd.lcd(root)
      end
    end,
  })
end

local function setup_autocmds()
  restore_cursor_position()
  remove_trailing_whitespace()
  highlight_yank()
  auto_resize_splits()
  setup_lsp_autocmds()
  setup_terminal_autocmds()
  setup_project_root()
end

setup_autocmds()
