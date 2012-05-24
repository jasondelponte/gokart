
# Application main entry point

Logger = modLoader.require 'libs/logger'
  
# This function runs once the page is loaded
onDocLoaded = ->
  return

window.addEventListener("load",onDocLoaded,false)
