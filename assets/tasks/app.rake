
namespace :app do
  desc 'Default action to perform, builds the app then runs it'
  task :default => [:start]

  desc 'Builds build app source files'
  task :build => ['www:build', 'server:build']

  desc 'Cleans the build paths for build parts of the app'
  task :clean => [:stop, 'www:clean', 'server:clean']

  desc 'Cleans the build paths then builds are source files'
  task :rebuild => [:clean, :build]

  desc 'Runs the test units for build source files'
  task :test => ['www:test', 'server:test']

  desc 'Stops and restarts the server'
  task :restart => [:stop, :start]

  desc 'Builds the app if needed, and starts it'
  task :start => [:build, 'server:start']

  desc 'Builds the app if wth debug, and starts it'
  task :startdebug => [:build, 'server:startdebug']

  desc 'Stops the server if it was running'
  task :stop => ['server:stop']

  desc 'Runs the guard command within bundler'
  task :guard => [:rebuild] do
    `bundle exec guard`
  end
end
