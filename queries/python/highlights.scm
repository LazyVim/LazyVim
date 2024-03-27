;; extends

; Set highlight to @variable so it appears similar to plaintext in .md
; otherwise will be highlighted as @string
; # %% [markdown] cell
((
  (comment) @_cell.marker.md
  . (expression_statement
      (string (string_content) @variable)))
  (#lua-match? @_cell.marker.md "^# %%%% %[markdown%]"))
