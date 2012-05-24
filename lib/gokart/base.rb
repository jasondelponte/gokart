require 'fileutils'

module Gokart
  attr_reader :app_name, :app_parent_path, :app_base_path, :assets_path
  attr_accessor :logger

  class Base
    # 
  	def app_name_valid?
      unless File.stat(@app_parent_path).readable?
      	@logger.fatal("App parent directory is not readable")
      	return false
      end
      unless File.stat(@app_parent_path).writable?
      	@logger.fatal("App parent directory is not writable")
      	return false
      end
      if Dir.exist?(@app_base_path)
      	@logger.fatal("App #{@app_name} directory already exists")
      	return false
      end
      return true
  	end

  	def build_app
      return false unless create_dirs()
      return false unless copy_files()

      return true
  	end

    def create_dirs
        directories().each() do |dir|
          begin
            FileUtils::mkdir_p dir
          rescue Exception => e
            @logger.fatal "Failed to create directory #{dir}, because #{e}"
            return false
          end
        end
      return true
    end

    def copy_files
        Dir.glob(@assets_path.join("**","*")).each() do | inFile |
          begin
            outFile = inFile.partition(@assets_path.to_s)[2]
            next if outFile.empty? || FileTest::directory?(inFile)
            FileUtils::cp inFile, @app_base_path.to_s()+outFile
          rescue Exception => e
            @logger.fatal "Failed to copy #{outFile} to #{@app_base_path}, because #{e}"
            return false
          end
        end

      return true
    end
  end
end