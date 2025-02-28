-- lua/plugins/git.lua
return {
  {
    'f-person/git-blame.nvim',
  },
  {
    'kdheepak/lazygit.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
  },
}
