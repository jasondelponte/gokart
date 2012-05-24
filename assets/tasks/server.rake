require 'rake'

namespace :app do
  namespace :server do
    task :init do
      dirs = []
      dirs << GO_BUILD_PATH

      dirs.each do |path|
        begin
          FileUtils::mkdir_p(path) if (!FileTest::directory?(path))
        rescue
          puts "Failed to create directory #{path}"
        end
      end
    end

    desc 'Builds the existing source'
    task :build => [:init] do
      `GOPATH="#{ROOT}" go install #{GO_APP_NAME} 1>&2`
    end

    desc 'Cleans the build path'
    task :clean do
      paths = []
      paths << File.join(GO_BUILD_PATH, 'server')

      paths.each do |path|
        begin
          FileUtils::rm_rf path
        rescue
          puts "Failed to clean server's #{path}"
        end
      end
    end

    desc 'Runs the test units for the source files'
    task :test => [:build] do
    	`GOPATH="#{ROOT}" go test #{GO_APP_NAME} 1>&2`
    end

    desc 'Runs the server, killing old instance if there was one.'
    task :start, [:port, :static] => [:stop] do |t, args|
      args.with_defaults(:port => 8080, :static => :true)
      `./bin/#{GO_APP_NAME} -port=#{args[:port]} -static=#{args[:static]} -tmpl="#{TMPL_BUILD_PATH}" -www="#{MIN_WWW_PATH}"`
    end

    desc 'Runs the server, killing old instance if there was one.'
    task :startdebug, [:port] => [:stop] do |t, args|
      args.with_defaults(:port => 8080, :static => :true)
      `./bin/#{GO_APP_NAME} -port=#{args[:port]} -debug=true -static=true -tmpl="#{TMPL_BUILD_PATH}" -www="#{DEBUG_WWW_PATH}"`
    end

    desc 'Stops the server if it was running'
    task :stop do
    end
  end
end
