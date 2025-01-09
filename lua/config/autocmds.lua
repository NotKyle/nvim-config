-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Setup for MiniFiles
local function setup_minifiles()
  local show_dotfiles = true
  local filter_hide = function(fs_entry)
    return not vim.startswith(fs_entry.name, ".")
  end

  local toggle_dotfiles = function()
    show_dotfiles = not show_dotfiles
    MiniFiles.refresh({ content = { filter = show_dotfiles and nil or filter_hide } })
  end

  local map_split = function(buf_id, direction)
    local rhs = function()
      local new_target_window
      vim.api.nvim_win_call(MiniFiles.get_target_window(), function()
        vim.cmd(direction .. " split")
        new_target_window = vim.api.nvim_get_current_win()
      end)
      MiniFiles.set_target_window(new_target_window)
    end
    vim.keymap.set("n", direction == "belowright horizontal" and "gs" or "gv", rhs, {
      buffer = buf_id,
      desc = "Split " .. direction,
    })
  end

  local files_set_cwd = function()
    local cur_directory = vim.fs.dirname(MiniFiles.get_fs_entry().path)
    vim.fn.chdir(cur_directory)
    print("Changed working directory to " .. cur_directory)
  end

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesBufferCreate",
    callback = function(args)
      local buf_id = args.data.buf_id
      vim.keymap.set("n", "g.", toggle_dotfiles, { buffer = buf_id, desc = "Toggle dotfiles visibility" })
      map_split(buf_id, "belowright horizontal")
      map_split(buf_id, "belowright vertical")
      vim.keymap.set("n", "g~", files_set_cwd, { buffer = buf_id, desc = "Set CWD to MiniFiles directory" })
    end,
  })

  vim.api.nvim_create_autocmd("User", {
    pattern = "MiniFilesWindowOpen",
    callback = function(args)
      local win_id = args.data.win_id
      vim.wo[win_id].winblend = 30
      local config = vim.api.nvim_win_get_config(win_id)
      config.border, config.title_pos = "double", "left"
      vim.api.nvim_win_set_config(win_id, config)
    end,
  })
end
setup_minifiles()

-- Group for Miscellaneous Autocommands
local group_name = "Random"
vim.api.nvim_create_augroup(group_name, { clear = true })

-- Auto-resize windows equally on Vim resize
vim.api.nvim_create_autocmd("VimResized", {
  group = group_name,
  desc = "Keep windows equally resized",
  command = "wincmd =",
})

-- Set terminal windows to no number, no relative number, and no sign column
vim.api.nvim_create_autocmd("TermOpen", {
  group = group_name,
  callback = function()
    vim.fn.jobstart({ "zsh" }, { detach = true })
  end,
})

-- Prevent auto-continuation of comments
vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function()
    vim.opt_local.formatoptions:remove({ "r", "o" })
  end,
})

-- Automatically check for file changes when focus is gained
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold" }, {
  callback = function()
    vim.cmd("checktime") -- Runs the command
    -- vim.notify("File changes checked", vim.log.levels.INFO)
  end,
})

-- Show LSP diagnostics in floating window on cursor hold
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

-- LSP diagnostic configuration
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Function to run PHP CS Fixer
local phpcs_enabled = false

if phpcs_enabled then
  local function php_cs_fixer_format()
    local file = vim.fn.expand("%:p")
    if vim.fn.executable("vendor/bin/php-cs-fixer") == 1 then
      vim.cmd("silent! !vendor/bin/php-cs-fixer fix --config=.php-cs-fixer.dist.php " .. file)
    else
      vim.notify("PHP CS Fixer not found in vendor/bin", vim.log.levels.ERROR)
    end
  end

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "*.php",
    callback = function()
      php_cs_fixer_format()
    end,
  })
end

-- Start and stop project commands
local jobs = {}

local function run_command(cmd, on_exit)
  return vim.fn.jobstart(cmd, { on_exit = on_exit })
end

function StartProject()
  local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
  StopProject()

  run_command("docker container stop $(docker container ls -aq)", function()
    run_command("docker-compose up -d", function()
      run_command("yarn watch", function(_, code)
        if code == 0 then
          print("Project " .. project_name .. " started successfully")
        else
          print("Error starting project " .. project_name)
        end
      end)
    end)
  end)
end

function StopProject()
  for _, job_id in pairs(jobs) do
    if job_id and vim.fn.jobwait({ job_id }, 0)[1] == -1 then
      vim.fn.jobstop(job_id)
    end
  end
  jobs = {}
  print("Project processes stopped")
end

vim.cmd("command! StartProject lua StartProject()")
vim.cmd("command! StopProject lua StopProject()")

-- vim.api.nvim_create_autocmd("VimLeavePre", {
--   callback = StopProject,
-- })

-- SCSS-specific settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "yaml", "toml", "scss" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "yaml", "toml" },
  callback = function()
    vim.opt_local.shiftwidth = 2
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    if vim.bo.filetype == "php" or vim.bo.filetype == "lua" then
      local opts = { focusable = false, border = "rounded", source = "always", scope = "cursor" }
      vim.diagnostic.open_float(nil, opts)
    end
  end,
})

-- Auto source .env
vim.api.nvim_create_autocmd("BufReadPre", {
  pattern = ".env",
  callback = function()
    vim.fn.system("source .env")
    vim.notify("Environment variables loaded", vim.log.levels.INFO)
  end,
})
