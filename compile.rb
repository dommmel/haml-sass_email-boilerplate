#! /usr/bin/env ruby

require "./settings.rb"
require 'haml'
require 'sass'

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
  p filename
  throw "Could not find file."
end

def partial filename
  source = File.read(find(filename))
  engine = Haml::Engine.new(source)
  engine.render(binding)
end

Sass.compile_file("sass/style.scss", "build/style.css")
File.open("build/index.html", 'w') {|f| f.write(partial "haml/index.haml") }
#puts partial ARGV[0]