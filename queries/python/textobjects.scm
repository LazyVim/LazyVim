; extends

; Code cells in percent format: # %%, #%% with any metadata
((comment) @cell.marker
  (#lua-match? @cell.marker "^# *%%%%.*"))

