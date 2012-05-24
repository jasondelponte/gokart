require 'fileutils'
require 'coffee_script'
require 'sass'
require 'yui/compressor'
require 'uglifier'
require 'sprockets'

sprockets = (Sprockets::Environment.new(ROOT) { |env| env.logger = Logger.new(STDOUT) })
sprockets.append_path WWW_SRC_VENDOR_PATH.join('css').to_s
sprockets.append_path WWW_SRC_APP_PATH.join('sass').to_s
sprockets.append_path WWW_SRC_VENDOR_PATH.join('js').to_s
sprockets.append_path WWW_SRC_APP_PATH.join('coffee').to_s
sprockets.append_path WWW_SRC_APP_PATH.join('templates').to_s
# Note: Requires JVM for YUI
sprockets.css_compressor = YUI::CssCompressor.new
sprockets.js_compressor  = Uglifier.new(mangle: true)

# Add the go template mime type/extension so we can specify the directive processors in them
sprockets.register_mime_type('text/gotmpl', '.gotmpl')
sprockets.register_processor('text/gotmpl', Sprockets::DirectiveProcessor)


desc 'Iterates over the input directory building a list of coffee files to compile'
def coffee(inDir, outDir)
  Dir.glob("#{inDir}/**/*.coffee").each do |file|
    outFile = file.partition(inDir)[2]
    next if (outFile.empty?)
    outFile.sub!(/coffee$/, 'js')
    coffee_compile(file, outDir+outFile)
  end
end

desc 'Compiles the coffee script file and writes it to the out'
def coffee_compile(inFile, outFile)
  begin
    File.delete(outFile) if (FileTest::file?(outFile))
    FileUtils::mkdir_p(File.dirname(outFile)) if (!FileTest::directory?(File.dirname(outFile)))

    f = File.new(outFile, "w")
    f.write(CoffeeScript.compile(File.read(inFile)))
    f.close()
  rescue
    puts "Failed to compile #{inFile} to #{outFile}"
  end
end

namespace :app do
  namespace :www do
    task :init do
      paths = []
      paths << MIN_WWW_PATH.join('js')
      paths << MIN_WWW_PATH.join('css')
      paths << MIN_WWW_PATH.join('images')
      paths << MIN_WWW_PATH.join('partials')
      paths << DEBUG_WWW_PATH.join('js')
      paths << DEBUG_WWW_PATH.join('css')
      paths << DEBUG_WWW_PATH.join('images')
      paths << DEBUG_WWW_PATH.join('partials')
      paths << TMPL_BUILD_PATH

      paths.each do |path|
        begin
          FileUtils::mkdir_p(path) if (!FileTest::directory?(path))
        rescue
          puts "Failed to create directory #{path}"
        end
      end
    end

    task :spec_coffee do
      coffee "#{WWW_SRC_SPEC_PATH}/coffee", WWW_SPEC_PATH.to_s
    end

    task :images do
      from  = WWW_SRC_APP_PATH.join('images')
      to    = DEBUG_WWW_PATH
      begin
        FileUtils::cp_r from, to
      rescue
        puts "Failed to copy directory #{from} to #{to}"
      end
    end

    task :partials do
      from = WWW_SRC_APP_PATH.join('partials')
      to   = DEBUG_WWW_PATH
      begin
        FileUtils::cp_r from, to
      rescue
        puts "Failed to copy directory #{from} to #{to}"
      end
    end

    task :vendor do
      from = "#{WWW_SRC_VENDOR_PATH}/images"
      to   = DEBUG_WWW_PATH.join('vendor', 'images')
      begin
        FileUtils::cp_r from, to
      rescue
        puts "Failed to copy directory #{from} to #{to}"
      end
    end

    desc 'Compiles the asset files into those usable by the browser'
    task :compile  do
      ASSET_BUNDLES.each do |bundle|
        assets = sprockets.find_asset(bundle)

        # drop all extentions except the first
        realname = assets.pathname.basename.to_s.split(".")[0..1].join(".")
        prefix = File.extname(realname).split('.').last
        outfile = MIN_WWW_PATH.join(prefix, realname)

        assets.write_to(outfile)
        assets.write_to("#{outfile}.gz")

        # For each asset in the bundle write them to the debug output
        assets.to_a.each do |asset|
          # strip filename.css.foo.bar.css multiple extensions, but maintain the base directory of the file
          realname = asset.pathname.basename.to_s.split(".")[0..1].join(".")
          outPath = DEBUG_WWW_PATH.join(prefix, File.dirname(asset.logical_path))
          FileUtils::mkdir_p(outPath) if (!FileTest::directory?(outPath))
          asset.write_to(outPath.join(realname))
        end
      end
    end

    desc 'Compiles the go template files and concats them'
    task :compile_templates  do
      assets = sprockets.find_asset("application.gotmpl")

      # drop all extentions except the first
      realname = assets.pathname.basename.to_s.split(".")[0..1].join(".")
      outfile = TMPL_BUILD_PATH.join(realname)

      assets.write_to(outfile)
    end

    desc 'Builds the existing source'
    task :build => [:init,:compile,:compile_templates,:spec_coffee,:images,:partials]

    desc 'Cleans the build path'
    task :clean do
      paths = []
      paths << ASSETS_PATH
      paths << TMPL_BUILD_PATH
      paths << Dir.glob("#{WWW_SPEC_PATH}/*.js")

      paths.each do |path|
        begin
          FileUtils::rm_rf path
        rescue
          puts "Failed to clean www's #{path}"
        end
      end
    end

    desc 'Runs the test units for the source files'
    task :test => [:build, 'jasmine:ci']

  end
end
