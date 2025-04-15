return function(lspconfig)
  lspconfig.harper_ls.setup {
    root_dir = require('lspconfig.util').root_pattern('eslint.config.js', '.git'),
    settings = {
      workingDirectory = { mode = 'location' },
      ['harper-ls'] = {
        userDictPath = '',
        fileDictPath = '',
        linters = {
          SpellCheck = true,
          SpelledNumbers = false,
          AnA = true,
          SentenceCapitalization = false, -- 🚫 disable this linter
          UnclosedQuotes = true,
          WrongQuotes = false,
          LongSentences = true,
          RepeatedWords = true,
          Spaces = true,
          Matcher = true,
          CorrectNumberSuffix = true,
        },
        codeActions = {
          ForceStable = false,
        },
        markdown = {
          IgnoreLinkTitle = false,
        },
        diagnosticSeverity = 'hint',
        isolateEnglish = false,
        dialect = 'British', -- 🇬🇧
      },
    },
  }
end
