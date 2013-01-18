# A sample Guardfile
# More info at https://github.com/guard/guard#readme

guard 'rake', :task => 'compile_sass' do
  watch(%r{^src/sass/(.+)\.scss})
end

guard 'rake', :task => 'compile_haml' do
  watch(%r{^src/haml/(.+)\.haml})
end

guard 'rake', :task => 'copy_images' do
  watch(%r{^src/images})
end