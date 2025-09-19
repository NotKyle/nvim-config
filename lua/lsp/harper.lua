return {
  -- root_dir = lspconfig.util.root_pattern('.git', '.harper-ls.json'),
  root_dir = vim.fn.getcwd(),
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
        ToDoHyphen = false,
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
