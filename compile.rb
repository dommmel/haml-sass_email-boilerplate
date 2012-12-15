#! /usr/bin/env ruby

@build_folder = "build"
@src_folder = "src"
@sass_folder = "#{@src_folder}/sass"
@haml_folder = "#{@src_folder}/haml"
@css_folder ="#{@build_folder}/assets"
@assets_folder ="#{@build_folder}/assets"
@stylesheet_filename = "style"
@markup_filename = "index"
@input_filenames = ['images', "#{@stylesheet_filename}.css"]
@assets_zipfile = "#{@assets_folder}.zip"

require "./#{@src_folder}/settings.rb"
require 'haml'
require 'sass'
require 'zip/zip'

module VarAccessor
  ::Sass::Script::Functions.send :include, self
  def self.variables
    @variables ||= {}
  end
 
  def self.set(values = {})
    variables.merge! values
  end
 
  def variable(value)
    #p VarAccessor.variables()
    #Sass::Script::String.new(@variables[:"#{value}"])
    Sass::Script::String.new(VarAccessor.variables()["#{value}".to_sym])
  end
end
def instance_variables_hash
 
end

# Make all instance_variables (starting with @) availabe to sass
VarAccessor.set  Hash[instance_variables.map { |name| [name.to_s.sub(/^@/,"").to_sym, instance_variable_get(name)] } ]

def find filename
  return filename if File.exists? filename
  filename = "./haml/"+filename
  return filename if File.exists? filename
  filename = @src_folder+"/"+filename
  return filename if File.exists? filename
  throw "Could not find file: #{filename}"
end

def partial (filename,locals={})
  source = File.read(find(filename))
  engine = Haml::Engine.new(source)
  engine.render(binding,locals)
end


## Compile assets
Sass.compile_file("#{@sass_folder}/#{@stylesheet_filename}.scss", "#{@assets_folder}/#{@stylesheet_filename}.css")
File.open("#{@build_folder}/#{@markup_filename}.html", 'w') {|f| f.write(partial "#{@haml_folder}/#{@markup_filename}.haml") }

# Zipping Assets
Zip.options[:on_exists_proc] = true #overwrite if exists
Zip.options[:continue_on_exists_proc] = true
Zip::ZipFile.open(@assets_zipfile, Zip::ZipFile::CREATE) do |zipfile|
  @input_filenames.each do |filename|
    zipfile.add(filename, @assets_folder + '/' + filename)
  end
end