# Static site builder
#
## Process:
# - Make a `build` directory
# - Compress assets and place in build directory
# - Gzip all files and place in build directory
# - Upload to S3
#
## Known limitations:
# - Only searches root directory
# 

require 'yui/compressor'

class Site < Thor
  include FileUtils
  include Thor::Actions
  
  desc "build", "build static files for deployment"
  def build
    mkdir_p "./build"
    compress
    gsub
    # gzip
  end
  
  desc "compress", "compress js or css"
  def compress
    Dir["*.{css,js}"].each do |file|
      extension = File.extname(file)
      if extension == ".js"
        result = YUI::JavaScriptCompressor.new.compress(File.read(file))
      else
        result = YUI::CssCompressor.new.compress(File.read(file))
      end
      filename = "./build/" + File.basename(file, extension) + ".min" + extension
      File.open(filename, 'w') { |file| file.write(result) }
      say_status("compress", filename, :green)            
    end
  end
  
  desc "gsub", "gsub css links to include inline css"
  def gsub
    copy_file 'index.html', 'build/index.html'
    gsub_file 'build/index.html', /<link rel="stylesheet"(.)+ \/>/ do |match|
      <<-END.gsub(/^ {6}/, '')
      <style type="text/css" media="screen">
      #{File.read('build/site.min.css')}
    	</style>
      END
    end
  end
  
  desc "gzip", "gzip html files"
  def gzip
    Dir["*.html"].each do |file|
      `gzip -9 -c #{file} > build/#{File.basename(file)}`
      say_status("gzip", "./build/#{File.basename(file)}", :green)
    end
  end
end