require 'rubygems'
require 'bundler'

Bundler.require

unless defined? ROOT
  ROOT = Pathname(File.dirname(__FILE__))

  ASSET_BUNDLES = %w( application.css application.js  )
  GO_APP_NAME =   'server'
  GO_BUILD_PATH = ROOT.join('bin')

  ASSETS_PATH =     ROOT.join('bin', 'assets')
  TMPL_BUILD_PATH = ASSETS_PATH.join('templates')
  MIN_WWW_PATH =    ASSETS_PATH.join('www-min')
  DEBUG_WWW_PATH =  ASSETS_PATH.join('www-debug')

  WWW_SPEC_PATH = ROOT.join('spec', 'javascripts')

  WWW_SRC_ROOT_PATH =   ROOT.join('src', 'www')
  WWW_SRC_APP_PATH =    WWW_SRC_ROOT_PATH.join('app')
  WWW_SRC_VENDOR_PATH = WWW_SRC_ROOT_PATH.join('vendor')
  WWW_SRC_SPEC_PATH =   WWW_SRC_ROOT_PATH.join('spec')
end
