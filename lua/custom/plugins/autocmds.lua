local api = vim.api
local fn = vim.fn
local o = vim.o

-- Restore cursor to file position in previous editing session
api.nvim_create_autocmd('BufReadPost', {
  callback = function(args)
    local mark = api.nvim_buf_get_mark(args.buf, '"')
    local line_count = api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd 'normal! g`"zz'
    end
  end,
})

-- Remove trailing whitespace on save
api.nvim_create_autocmd('BufWritePre', {
  callback = function()
    local save_cursor = fn.getpos '.'
    vim.cmd [[%s/\s\+$//e]]
    fn.setpos('.', save_cursor)
  end,
})

-- Highlight yanked text
api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 40,
    }
  end,
})

-- Keep the cursor position when yanking
local cursorPreYank

vim.keymap.set({ 'n', 'x' }, 'y', function()
  cursorPreYank = api.nvim_win_get_cursor(0)
  return 'y'
end, { expr = true })

vim.keymap.set('n', 'Y', function()
  cursorPreYank = api.nvim_win_get_cursor(0)
  return 'y$'
end, { expr = true })

api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    if vim.v.event.operator == 'y' and cursorPreYank then
      api.nvim_win_set_cursor(0, cursorPreYank)
    end
  end,
})

-- Auto resize splits when the terminal's window is resized
api.nvim_create_autocmd('VimResized', {
  command = 'wincmd =',
})

-- Fix scrolloff when you are at the EOF
api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'WinScrolled' }, {
  group = api.nvim_create_augroup('ScrollEOF', { clear = true }),
  callback = function()
    if api.nvim_win_get_config(0).relative ~= '' then
      return -- Ignore floating windows
    end

    local win_height = fn.winheight(0)
    local scrolloff = math.min(o.scrolloff, math.floor(win_height / 2))
    local visual_distance_to_eof = win_height - fn.winline()

    if visual_distance_to_eof < scrolloff then
      local win_view = fn.winsaveview()
      fn.winrestview { topline = win_view.topline + scrolloff - visual_distance_to_eof }
    end
  end,
})

-- Automatically split help buffers to the right
api.nvim_create_autocmd('FileType', {
  pattern = 'help',
  command = 'wincmd L',
})

-- Autocreate a dir when saving a file
api.nvim_create_autocmd('BufWritePre', {
  group = api.nvim_create_augroup('auto_create_dir', { clear = true }),
  callback = function(event)
    if event.match:match '^%w%w+:[\\/][\\/]' then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    fn.mkdir(fn.fnamemodify(file, ':p:h'), 'p')
  end,
})

-- Correct terminal background color according to colorscheme
api.nvim_create_autocmd({ 'UIEnter', 'ColorScheme' }, {
  callback = function()
    if api.nvim_get_hl(0, { name = 'Normal' }).bg then
      io.write(string.format('\027]11;#%06x\027\\', api.nvim_get_hl(0, { name = 'Normal' }).bg))
    end
    api.nvim_create_autocmd('UILeave', {
      callback = function()
        io.write '\027]111\027\\'
      end,
    })
  end,
})

-- Remove UI clutter in the terminal
api.nvim_create_autocmd('TermOpen', {
  callback = function()
    local is_terminal = api.nvim_get_option_value('buftype', { buf = 0 }) == 'terminal'
    o.number = not is_terminal
    o.relativenumber = not is_terminal
    o.signcolumn = is_terminal and 'no' or 'yes'
  end,
})

-- Auto jump to last position
api.nvim_create_autocmd('BufReadPost', {
  group = api.nvim_create_augroup('auto-last-position', { clear = true }),
  callback = function(args)
    local position = api.nvim_buf_get_mark(args.buf, [["]])
    local winid = fn.bufwinid(args.buf)
    pcall(api.nvim_win_set_cursor, winid, position)
  end,
})

-- Auto change local current directory
api.nvim_create_autocmd('BufWinEnter', {
  group = api.nvim_create_augroup('auto-project-root', {}),
  callback = function(args)
    if api.nvim_get_option_value('buftype', { buf = args.buf }) ~= '' then
      return
    end

    local root = vim.fs.root(args.buf, function(name, path)
      local patterns = { '.git', 'Cargo.toml', 'go.mod', 'build/compile_commands.json' }
      local abspaths = { fn.stdpath 'config' }
      local parentpaths = { '~/.config', '~/prj' }

      return vim.iter(patterns):any(function(filepat)
        return filepat == name
      end) or vim.iter(abspaths):any(function(dirpath)
        return vim.fs.normalize(dirpath) == path
      end) or vim.iter(parentpaths):any(function(ppath)
        return vim.fs.normalize(ppath) == vim.fs.dirname(path)
      end)
    end)
    if root then
      vim.cmd.lcd(root)
    end
  end,
})

return {}
