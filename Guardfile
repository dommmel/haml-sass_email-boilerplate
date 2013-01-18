# Watch markup
guard 'rake', :task => 'compile_sass' do
  watch(%r{^src/sass/(.+)\.scss})
end

# Watch styles
guard 'rake', :task => 'compile_haml' do
  watch(%r{^src/haml/(.+)\.haml})
end

# Watch images
guard 'rake', :task => 'copy_images' do
  watch(%r{^src/images})
end

# Watch  settings
guard 'rake', :task => 'compile_haml' do
  watch(%r{^src/settings.rb})
end

guard 'rake', :task => 'compile_sass' do
  watch(%r{^src/settings.rb})
end