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
      `GOPATH="#{ROOT}:$GOPATH" go install #{GO_APP_NAME} 1>&2`
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
    	`GOPATH="#{ROOT}:$GOPATH" go test #{GO_APP_NAME} 1>&2`
    end

    desc 'Runs the server'
    task :start, [:config] => [:stop] do |t, args|
      args.with_defaults(:config => "./config/config-release.json")
      `./bin/#{GO_APP_NAME} -config="#{args[:config]}"`
    end

    desc 'Runs the server in debug mode'
    task :startdebug, [:port] => [:stop] do |t, args|
      args.with_defaults(:config => "./config/config-debug.json")
      `./bin/#{GO_APP_NAME} -config="#{args[:config]}"`
    end

    desc 'Stops the server if it was running'
    task :stop do
    end
  end
end
