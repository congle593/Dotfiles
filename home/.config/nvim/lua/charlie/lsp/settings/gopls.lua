return {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
	      shadow = true,
      },
      codelenses = {
        generate = true, -- show the `go generate` lens.
        gc_details = true -- show a code lens toggling the display of gc's choices.
      },
      usePlaceholders = true,
      completeUnimported = true,
      staticcheck = true,
      matcher = "fuzzy",
      diagnosticsDelay = "500ms",
      symbolMatcher = "fuzzy",
    },
  },
}
