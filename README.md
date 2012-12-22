# Go Kart #
Combination of tools which will make developing webapps using go easier. The gokart gem by default combines SASS, Coffee Script, Rake, and Sprockets with Go to provide a great development environment. This environment supports test driven development (TDD) with ruby guard and jasmine.
There are no external dependencies other than Go and ruby (which I expect you already have...). All dependencies are installed via bundler after the project directory is created.

Example [Presentationn](https://jasondelponte.com/goapps/gokart/presentation/show)


# Usage #
With ruby (1.9.1 min maybe?) all you need to do is:
```
gem install gokart
```

Once installed to create a new go + sprockets environment:
```
gokart APP_NAME
```

This will create a folder of APP_NAME, build the environment, and run bundle install to pull in the gem files that are needed for the environment if you don't already have them.  There are also several rake commands you can use to build/run/deploy the environment. Checkout rake --tasks for a list of them.  In general you'll probably only ever need the app:x commands not app:server:x or app:www:x.


# Environment Structure #
The environment is split into the following sections:
* bin/ - This is where the application will run from once built, and where all the assets will be compiled to.
* bin/server/ - Compiled Go http server.
* bin/assets/templates/ - Compiled Go HTML templates
* bin/assets/www-min/ - Compiled and minified CSS/JS/images using sprockets
* bin/assets/www-debug/ - Compiled, but non-minified/concatonated CSS/JS source, images are here also
* spec/javascripts/ - Where all of the compiled JS specs will be written to, and run from. Note: Currently these do not go through sprockets, but only the coffee-script compiler. So no preprocessing is available
* spec/javascripts/support - Configuration files for Jasmine. jasmin.yml contains the script specifying the source files to load, and what order to load them in.
* src/server/ - All of your Go code will go here following the normal Go 1.0 directory pattern
* src/www/app/ - All of you Coffee script, sass, and Go Template are found here
* src/www/spec/ - All coffee script spec files which will be compiled into js and run using jasmine.
* src/www/vendor/ - js/css/image files for third party tools and libraries
* tasks/ - Rake tasks to build, run, and test the application. There are several tasks which you can run do 'rake --tasks' to see a complete list of them. 'rake app:test' to run test units, 'rake app:start' to build and run, use rake app:startdebug for a debug build. Note: when you do 'rake jasmine' or rake 'app:guard' you probably want to start these tasks in different tabs because they run until killed.
