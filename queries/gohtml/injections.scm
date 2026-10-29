; inherits: gotmpl

; The gotmpl grammar leaves everything outside {{ }} as an opaque (text) node,
; so the templated language is never parsed. gohtml is the html/template
; dialect, mirroring how `helm` injects yaml into the same grammar.
;
; Combined, because a tag or attribute is regularly split across several text
; nodes by an action in between (e.g. <img src="{{ .URL }}" alt="{{ .Alt }}">);
; parsed separately, each fragment is an incomplete document.
((text) @injection.content
  (#set! injection.language "html")
  (#set! injection.combined))
