-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- MiniFiles Window Open Autocmd
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesWindowOpen",
  callback = function(args)
    local win_id = args.data.win_id

    -- Customize window-local settings
    vim.wo[win_id].winblend = 30
    local config = vim.api.nvim_win_get_config(win_id)
    config.border, config.title_pos = "double", "left"
    vim.api.nvim_win_set_config(win_id, config)
  end,
})

-- Toggle Dotfiles Visibility in MiniFiles
local show_dotfiles = true
local filter_show = function(fs_entry)
  return true
end
local filter_hide = function(fs_entry)
  return not vim.startswith(fs_entry.name, ".")
end

local toggle_dotfiles = function()
  show_dotfiles = not show_dotfiles
  MiniFiles.refresh({ content = { filter = show_dotfiles and filter_show or filter_hide } })
end

-- Map 'g.' to toggle dotfiles visibility in MiniFiles
vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = args.data.buf_id })
  end,
})

-- Split Window Mapping in MiniFiles
local map_split = function(buf_id, lhs, direction)
  local rhs = function()
    local new_target_window
    vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
      vim.cmd(direction .. " split")
      new_target_window = vim.api.nvim_get_current_win()
    end)
    MiniFiles.set_target_window(new_target_window)
  end
  vim.keymap.set("n", lhs, rhs, { buffer = buf_id, desc = "Split " .. direction })
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    map_split(args.data.buf_id, "gs", "belowright horizontal")
    map_split(args.data.buf_id, "gv", "belowright vertical")
  end,
})

-- Set Current Working Directory to the Directory of the Current File in MiniFiles
local files_set_cwd = function()
  local cur_directory = vim.fs.dirname(MiniFiles.get_fs_entry().path)
  vim.fn.chdir(cur_directory)
end

vim.api.nvim_create_autocmd("User", {
  pattern = "MiniFilesBufferCreate",
  callback = function(args)
    vim.keymap.set("n", "g~", files_set_cwd, { buffer = args.data.buf_id })
  end,
})

-- Create a Group for Miscellaneous Autocommands
local group_name = "Random"
vim.api.nvim_create_augroup(group_name, { clear = true })

-- Auto-resize Windows Equally on Vim Resize
vim.api.nvim_create_autocmd("VimResized", {
  group = group_name,
  desc = "Keep windows equally resized",
  command = "tabdo wincmd =",
})

-- Set Terminal Windows to No Number, No Relative Number, and No Sign Column
vim.api.nvim_create_autocmd("TermOpen", {
  group = group_name,
  command = "setlocal nonumber norelativenumber signcolumn=no",
})

-- Prevent Auto-continuation of Comments
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- Automatically Check for File Changes When Focus is Gained
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  command = "checktime",
})

-- Show LSP Diagnostics in Floating Window on Cursor Hold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    local opts = {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = " ",
      scope = "cursor",
    }
    vim.diagnostic.open_float(nil, opts)
  end,
})

-- LSP Diagnostic Configuration
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Disable Virtual Text for Diagnostics on Buffer Enter
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    vim.diagnostic.config({ virtual_text = false })
  end,
})

local phpcs_enabled = false

if phpcs_enabled then
  -- Function to run PHP CS Fixer
  local function php_cs_fixer_format()
    local file = vim.fn.expand("%:p") -- Get the full file path of the current buffer
    -- print("Running PHP CS Fixer on " .. file)
    -- vim.cmd("silent! !vendor/bin/php-cs-fixer fix " .. file)
    vim.cmd("silent! !vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.dist.php " .. file)
  end

  -- Create an autocommand for PHP files
  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.php",
    callback = function()
      php_cs_fixer_format()
    end,
  })
end

-- Create a command to start the project
-- We need to:
-- docker down anny running containers (docker container stop $(docker container ls -aq))
-- docker-compose up -d
-- yarn watch
-- Store job IDs
local jobs = {}

function StartProject()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")

  -- Stop any previous jobs if they are still running
  StopProject()

  -- Start each process and save job IDs
  jobs.stop_containers = vim.fn.jobstart("docker container stop $(docker container ls -aq)", {
    on_exit = function()
      jobs.compose_up = vim.fn.jobstart("docker-compose up -d", {
        on_exit = function()
          jobs.yarn_watch = vim.fn.jobstart("yarn watch", {
            on_stdout = function(_, data)
              print(table.concat(data, "\n"))
            end,
            on_exit = function()
              print("Project " .. project_name .. " started")
            end,
          })
        end,
      })
    end,
  })
end

function StopProject()
  -- Terminate each job if it is running
  for _, job_id in pairs(jobs) do
    if job_id and vim.fn.jobwait({ job_id }, 0)[1] == -1 then
      vim.fn.jobstop(job_id)
    end
  end
  jobs = {} -- Clear the jobs table
  print("Project processes stopped")
end

vim.cmd("command! StartProject lua StartProject()")
vim.cmd("command! StopProject lua StopProject()")

-- Optionally stop project processes on Neovim exit
vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = StopProject,
})
