;extends

; # %% [markdown]
; """
; This is markdown cell, with triple-quote multiline string
; """
((comment) @cell.marker
  . (expression_statement
    (string
      (string_start) @_comment_mark
      (string_content) @injection.content)
    )
  (#lua-match? @cell.marker "^# *%%%% *%[markdown%]")
  (#eq? @_comment_mark "\"\"\"")
  (#set! injection.language "markdown")
  )
