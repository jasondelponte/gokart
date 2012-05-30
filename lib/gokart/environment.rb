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
        Pathname(@app_base_path).join('bin'),
        Pathname(@app_base_path).join('lib'),
        Pathname(@app_base_path).join('spec','javascripts','support'),
        Pathname(@app_base_path).join('src','server'),
        Pathname(@app_base_path).join('src','www','app','coffee','helpers'),
        Pathname(@app_base_path).join('src','www','app','coffee','libs'),
        Pathname(@app_base_path).join('src','www','app','coffee'),
        Pathname(@app_base_path).join('src','www','app','erb_helpers'),
        Pathname(@app_base_path).join('src','www','app','images'),
        Pathname(@app_base_path).join('src','www','app','partials'),
        Pathname(@app_base_path).join('src','www','app','sass'),
        Pathname(@app_base_path).join('src','www','app','templates'),
        Pathname(@app_base_path).join('src','www','spec','coffee'),
        Pathname(@app_base_path).join('src','www','vendor','css'),
        Pathname(@app_base_path).join('src','www','vendor','images'),
        Pathname(@app_base_path).join('src','www','vendor','js'),
        Pathname(@app_base_path).join('tasks'),
      ]
    end
  end
end