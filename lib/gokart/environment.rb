require 'gokart/base'

require 'pathname'
require 'logger'

module Gokart
  class Environment < Base
  	def initialize(root, app_name)
  	  @logger = Logger.new($stderr)
  	  @logger.level = Logger::FATAL

  	  @app_parent_path = Pathname(Dir.pwd.to_s)
  	  @app_base_path = @app_parent_path.join(app_name)
  	  @app_name = app_name
  	  @assets_path = Pathname(root).join('assets')
  	end

    def directories
      paths = [
        File.join(@app_name,'bin'),
        File.join(@app_name,'config'),
        File.join(@app_name,'lib'),
        File.join(@app_name,'pkg'),
        File.join(@app_name,'spec'),
        File.join(@app_name,'src','server','config'),
        File.join(@app_name,'src','server','controller'),
        File.join(@app_name,'src','server','view'),
        File.join(@app_name,'src','www','app','erb_helpers'),
        File.join(@app_name,'src','www','app','images'),
        File.join(@app_name,'src','www','app','sass'),
        File.join(@app_name,'src','www','app','scripts','controllers'),
        File.join(@app_name,'src','www','app','scripts','models'),
        File.join(@app_name,'src','www','app','scripts','pages'),
        File.join(@app_name,'src','www','app','scripts','utilities'),
        File.join(@app_name,'src','www','app','scripts','views'),
        File.join(@app_name,'src','www','app','templates','pages'),
        File.join(@app_name,'src','www','app','templates','partials'),
        File.join(@app_name,'src','www','spec','helpers'),
        File.join(@app_name,'src','www','spec','support'),
        File.join(@app_name,'src','www','spec','utilities'),
        File.join(@app_name,'src','www','vendor','css'),
        File.join(@app_name,'src','www','vendor','images'),
        File.join(@app_name,'src','www','vendor','js'),
        File.join(@app_name,'tasks'),
      ]
    end
  end
end