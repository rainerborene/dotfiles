syn region erubyBlock      matchgroup=erubyDelimiter start="<%[-_]\?" end="[-_]\?%>" contains=erubyString keepend
syn region erubyExpression matchgroup=erubyDelimiter start="<%="      end="[-_]\?%>" contains=erubyString keepend
syn region erubyComment    matchgroup=erubyDelimiter start="<%#"      end="%>"       contains=@Spell
syn region erubyString     start=+"+ skip=+\\"+ end=+"+ contained

hi def link erubyDelimiter PreProc
hi def link erubyComment   Comment
hi def link erubyString    String
