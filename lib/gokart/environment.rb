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
      paths = []
    end
  end
end