return {
  "stephpy/vim-php-cs-fixer",
  config = function()
    vim.g.php_cs_fixer_level = "psr12"
    vim.g.php_cs_fixer_on_save = 1
    vim.g.php_cs_fixer_fixer = "vendor/bin/php-cs-fixer"
    vim.g.php_cs_fixer_path = "vendor/bin/php-cs-fixer"
    vim.g.php_cs_fixer_args = "--config=.php_cs"
    vim.g.php_cs_fixer_diff = 1
    vim.g.php_cs_fixer_diff_format = "vertical"
  end,
}
