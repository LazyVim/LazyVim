((text) @injection.content
    (#not-has-ancestor? @injection.content "envoy")
    (#set! injection.combined)
    (#set! injection.language php))
