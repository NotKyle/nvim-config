return {
  "echasnovski/mini.files",
  config = function()
    require("mini.files").setup({
      options = {
        use_as_default_explorer = true,
        permanent_delete = false,
      },
      windows = {
        preview = true,
        width_preview = 50,
        width_focus = 50,
        width_nofocus = 25,
        max_number = 2,
      },
      content = {
        filter = function(fs_entry)
          local whitelist = {
            ".env",
          }

          -- Check if the file is in the whitelist
          for _, whitelist_item in ipairs(whitelist) do
            if fs_entry.name == whitelist_item then
              return true
            end
          end

          -- Return true if the file name does not start with a dot
          return not vim.startswith(fs_entry.name, ".")
        end,
      },
    })
  end,
  version = false,
}
