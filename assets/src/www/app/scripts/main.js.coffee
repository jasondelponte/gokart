
# Application main entry point
define 'app', ['utilities/logger'], (Logger) ->

  # This function runs once the page is loaded
  onDocLoaded = ->
    return

  window.addEventListener("load", onDocLoaded, false)
