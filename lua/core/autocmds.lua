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
  -- Resize all splits equally when the Neovim window is resized
  vim.api.nvim_create_autocmd('VimResized', {
    callback = function()
      vim.cmd 'tabdo wincmd ='
    end,
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

  vim.api.nvim_create_autocmd('CompleteChanged', {
    callback = function()
      local completed_item = vim.v.completed_item
      if completed_item and completed_item.user_data then
        vim.defer_fn(function()
          vim.lsp.buf.hover()
        end, 100) -- Delay to allow menu redraw
      end
    end,
  })

  -- Show errors and warnings in a floating window
  -- vim.api.nvim_create_autocmd('CursorHold', {
  --   callback = function()
  --     vim.diagnostic.open_float(nil, { focusable = false, source = 'if_many' })
  --   end,
  -- })

  --https://www.reddit.com/r/neovim/comments/1jpbc7s/disable_virtual_text_if_there_is_diagnostic_in/
  local virtual_lines_change = false

  if virtual_lines_change then
    vim.diagnostic.config {
      virtual_text = true,
      virtual_lines = { current_line = true },
      underline = true,
      update_in_insert = false,
    }

    local og_virt_text
    local og_virt_line
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
      group = vim.api.nvim_create_augroup('diagnostic_only_virtlines', {}),
      callback = function()
        if og_virt_line == nil then
          og_virt_line = vim.diagnostic.config().virtual_lines
        end

        -- ignore if virtual_lines.current_line is disabled
        if not (og_virt_line and og_virt_line.current_line) then
          if og_virt_text then
            vim.diagnostic.config { virtual_text = og_virt_text }
            og_virt_text = nil
          end
          return
        end

        if og_virt_text == nil then
          og_virt_text = vim.diagnostic.config().virtual_text
        end

        local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

        if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
          vim.diagnostic.config { virtual_text = og_virt_text }
        else
          vim.diagnostic.config { virtual_text = false }
        end
      end,
    })

    local og_virt_text
    local og_virt_line
    vim.api.nvim_create_autocmd({ 'CursorMoved', 'DiagnosticChanged' }, {
      group = vim.api.nvim_create_augroup('diagnostic_only_virtlines', {}),
      callback = function()
        if og_virt_line == nil then
          og_virt_line = vim.diagnostic.config().virtual_lines
        end

        -- ignore if virtual_lines.current_line is disabled
        if not (og_virt_line and og_virt_line.current_line) then
          if og_virt_text then
            vim.diagnostic.config { virtual_text = og_virt_text }
            og_virt_text = nil
          end
          return
        end

        if og_virt_text == nil then
          og_virt_text = vim.diagnostic.config().virtual_text
        end

        local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1

        if vim.tbl_isempty(vim.diagnostic.get(0, { lnum = lnum })) then
          vim.diagnostic.config { virtual_text = og_virt_text }
        else
          vim.diagnostic.config { virtual_text = false }
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

-- Lua function for statusline
local function setupMacroMode()
  local reg = vim.fn.reg_recording()
  if reg ~= '' then
    return 'Recording @' .. reg
  end
  return ''
end

local function create_eslint_file()
  local eslint_config = vim.fn.expand '~/.config/eslint.config.js'
  local eslint_config_dest = vim.fn.getcwd() .. '/eslint.config.js'

  print('Source: ' .. eslint_config)
  print('Destination: ' .. eslint_config_dest)

  if vim.fn.filereadable(eslint_config_dest) == 0 then
    local file = io.open(eslint_config, 'r')
    if file then
      local content = file:read '*a'
      file:close()

      local new_file = io.open(eslint_config_dest, 'w')
      if new_file then
        new_file:write(content)
        new_file:close()
        print '✅ Created eslint.config.js in current directory.'
      else
        print '❌ Failed to create eslint.config.js: check permissions.'
      end
    else
      print('❌ Failed to read ESLint config file: ' .. eslint_config)
    end
  else
    print 'ℹ️ ESLint config already exists in project.'
  end
end

-- Create new command to create ESLint config
vim.api.nvim_create_user_command('CreateESLintConfig', create_eslint_file, {})

local function bufferhandling()
  vim.api.nvim_create_autocmd('BufHidden', {
    callback = function(args)
      vim.api.nvim_buf_delete(args.buf, { force = true })
    end,
  })
end

local bladeGrp = vim.api.nvim_create_augroup('BladeFiltypeRelated', { clear = true })
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.blade.php',
  group = bladeGrp,
  callback = function()
    vim.bo.filetype = 'blade'
  end,
})

local function setup_autocmds()
  restore_cursor_position()
  remove_trailing_whitespace()
  highlight_yank()
  auto_resize_splits()
  setup_lsp_autocmds()
  setup_terminal_autocmds()
  setup_project_root()
  setupMacroMode()
  -- bufferhandling()

  -- Disable any autosaves
end

setup_autocmds()
