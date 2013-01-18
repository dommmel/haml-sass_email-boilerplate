#! /usr/bin/env ruby

@target_folder = "target"
@src_folder = "src"
@sass_folder = "#{@src_folder}/sass"
@haml_folder = "#{@src_folder}/haml"
@stylesheet_filename = "style"
@markup_filename = "index"
@input_filenames = ['images', "#{@stylesheet_filename}.css"]
@assets_zipfile = "assets.zip"

require "./#{@src_folder}/settings.rb"
require 'haml'
require 'sass'
require 'zip/zip'

# Make all instance_variables (starting with @) availabe to sass
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
VarAccessor.set  Hash[instance_variables.map { |name| [name.to_s.sub(/^@/,"").to_sym, instance_variable_get(name)] } ]

# Try to locate a file
def find filename
  return filename if File.exists? filename
  filename = "./haml/"+filename
  return filename if File.exists? filename
  filename = @src_folder+"/"+filename
  return filename if File.exists? filename
  throw "Could not find file: #{filename}"
end

# Implement simple partials to use with HAML
def partial (filename,locals={})
  source = File.read(find(filename))
  engine = Haml::Engine.new(source)
  engine.render(binding,locals)
end


# Rake Tasks

directory @target_folder
directory "#{@target_folder}/images"

desc "Default task is set to compile_all"
task :default => :build

desc "target project"
task :build => [:compile_sass,:compile_haml,:copy_images]

desc "Compile sass to css"
task :compile_sass => @target_folder do
  Sass.compile_file("#{@sass_folder}/#{@stylesheet_filename}.scss", "#{@target_folder}/#{@stylesheet_filename}.css")
end

desc "Compile haml to html"
task :compile_haml => @target_folder do
  File.open("#{@target_folder}/#{@markup_filename}.html", 'w') {|f| f.write(partial "#{@haml_folder}/#{@markup_filename}.haml") }
end

desc "Copy over image files"
task :copy_images => "#{@target_folder}/images" do 
  sh "rsync -ru --delete #{@src_folder}/images/ #{@target_folder}/images/"
end

desc "Zip Assets"
task :zip_assets => [:build] do
  Zip.options[:on_exists_proc] = true #overwrite if exists
  Zip.options[:continue_on_exists_proc] = true
  Zip::ZipFile.open(@assets_zipfile, Zip::ZipFile::CREATE) do |zipfile|
    @input_filenames.each do |filename|
      zipfile.add(filename, @target_folder + '/' + filename)
    end
  end
end